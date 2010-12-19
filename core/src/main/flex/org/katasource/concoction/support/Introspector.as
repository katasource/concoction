package org.katasource.concoction.support {
import flash.events.IEventDispatcher;

import org.as3commons.lang.ClassUtils;
import org.as3commons.logging.ILogger;
import org.as3commons.logging.LoggerFactory;
import org.as3commons.reflect.Method;
import org.as3commons.reflect.Parameter;
import org.as3commons.reflect.Type;
import org.katasource.concoction.lifecycle.IDisposable;
import org.katasource.concoction.lifecycle.IInitializable;
import org.katasource.concoction.note.CallbackType;
import org.katasource.concoction.note.INotification;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class Introspector implements IDisposable, IInitializable {

    protected var _logger:ILogger;

    private var _processReactions:Boolean;
    private var _processResponses:Boolean;
    private var _reactions:Vector.<Reaction>;
    private var _responses:Vector.<Response>;
    private var _type:Type;

    public function Introspector(source:*, processResponses:Boolean = true, processReactions:Boolean = true) {
        if (source is Class) {
            _type = Type.forClass(source);
        } else if (source is Type) {
            _type = source;
        } else {
            _type = Type.forInstance(source);
        }
        _logger = LoggerFactory.getClassLogger(ClassUtils.forInstance(this));
        _processReactions = processReactions;
        _processResponses = processResponses;

        _reactions = new Vector.<Reaction>();
        _responses = new Vector.<Response>();
    }

    public function get processReactions():Boolean {
        return _processReactions;
    }

    public function get processResponses():Boolean {
        return _processResponses;
    }

    public function get reactions():Vector.<Reaction> {
        return _reactions.slice();
    }

    public function get responses():Vector.<Response> {
        return _responses.slice();
    }

    public function dispose():void {
        for each (var reaction:Reaction in _reactions) {
            reaction.dispose();
        }
        _reactions = null;
        _responses = null;
    }

    public function initialize():void {
        if (processReactions) {
            var reactionMethods:Vector.<Method> = findReactionMethods();

            if (reactionMethods.length > 0) {
                processReactionMethods(reactionMethods);
            }
        }

        if (processResponses) {
            var responseMethods:Vector.<Method> = findResponseMethods();

            if (responseMethods.length > 0) {
                processResponseMethods(responseMethods);
            }
        }
    }

    protected function get type():Type {
        return _type;
    }

    protected function addReaction(reaction:Reaction):void {
        _reactions.push(reaction);
    }

    protected function addResponse(response:Response):void {
        _responses.push(response);
    }

    protected function createReaction(eventDispatcher:IEventDispatcher, eventType:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):Reaction {
        return new Reaction(eventDispatcher, eventType, listener, useCapture, priority, useWeakReference);
    }

    protected function createResponse(notificationName:*, callback:Function, type:CallbackType = null):Response {
        return new Response(notificationName, callback, type);
    }

    protected function findReactionMethods():Vector.<Method> {
        throw new Error("Derived IntrospectiveMediators must override findReactionMethods()");
    }

    protected function findResponseMethods():Vector.<Method> {
        throw new Error("Derived IntrospectiveMediators must override findResponseMethods()");
    }

    protected function getCallbackType(method:Method):CallbackType {
        var parameters:Array = method.parameters;

        var callbackType:CallbackType;
        if (parameters && parameters.length > 0) {
            if (parameters.length > 1) {
                _logger.warn("[{0}.{1}] takes {2} parameters. Only 1 parameter is supported on [Response]s",
                        [type.name, method.name, parameters.length]);
            } else {
                var parameter:Parameter = parameters[0];

                if (parameter.type.clazz is INotification) {
                    callbackType = CallbackType.WITH_NOTIFICATION;
                } else {
                    callbackType = CallbackType.WITH_BODY;
                }
            }
        } else {
            callbackType = CallbackType.EMPTY;
        }
        return callbackType;
    }

    protected function getNotificationName(method:Method):* {
        throw new Error(type.name + ": Derived IntrospectiveMediators must override either " +
                "getNotificationName(Method) or processResponseMethods(Vector, INotificationRegistrar)");
    }

    protected function processReactionMethods(reactionMethods:Vector.<Method>):void {
        throw new Error("Derived IntrospectiveMediators must override processReactionMethods(Vector)")
    }

    protected function processResponseMethods(responseMethods:Vector.<Method>):void {
        for each (var method:Method in responseMethods) {
            var name:* = getNotificationName(method);
            if (name == null) {
                _logger.warn(type.name + ": Could not determine notification name for [" + method.name + "]");
            } else {
                var type:CallbackType = getCallbackType(method) || CallbackType.AUTOMATIC;
                var response:Response = createResponse(name, this[method.name], type);

                addResponse(response);
            }
        }
    }
}
}
