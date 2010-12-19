package org.katasource.concoction.support {
import org.as3commons.lang.StringUtils;
import org.as3commons.reflect.Method;
import org.as3commons.reflect.Parameter;
import org.katasource.concoction.note.CallbackType;
import org.katasource.concoction.note.INotification;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class MemberIntrospector extends Introspector {

    public static const REACTION_PREFIX:String = "reactTo";
    public static const RESPONSE_PREFIX:String = "respondTo";

    private var _reactionPrefix:String;
    private var _responsePrefix:String;

    public function MemberIntrospector(source:*, processResponses:Boolean = true, processReactions:Boolean = true) {
        super(source, processResponses, processReactions);

        _reactionPrefix = REACTION_PREFIX;
        _responsePrefix = RESPONSE_PREFIX;
    }

    public function get reactionPrefix():String {
        return _reactionPrefix;
    }

    public function set reactionPrefix(value:String):void {
        _reactionPrefix = value;
    }

    public function get responsePrefix():String {
        return _responsePrefix;
    }

    public function set responsePrefix(value:String):void {
        _responsePrefix = value;
    }

    override protected function findReactionMethods():Vector.<Method> {
        return getMethodsByPrefix(reactionPrefix);
    }

    override protected function findResponseMethods():Vector.<Method> {
        return getMethodsByPrefix(responsePrefix);
    }

    protected function getMethodsByPrefix(prefix:String):Vector.<Method> {
        var prefixLength:int = prefix.length;

        var methods:Vector.<Method> = new Vector.<Method>();
        for each (var method:Method in type.methods) {
            var methodName:String = method.name;
            if (methodName.length > prefixLength && StringUtils.startsWith(methodName, prefix)) {
                methods.push(method);
            }
        }
        return methods;
    }

    override protected function processReactionMethods(reactionMethods:Vector.<Method>):void {

    }

    override protected function processResponseMethods(responseMethods:Vector.<Method>):void {
        var prefixLength:int = responsePrefix.length;
        for each (var method:Method in responseMethods) {
            var notificationName:String = StringUtils.uncapitalize(method.name.substr(prefixLength));
            var callbackType:CallbackType;

            var parameters:Array = method.parameters;
            if (parameters && parameters.length > 0) {
                if (parameters.length > 1) {
                    _logger.warn("[{0}.{1}] takes {2} parameters. Only 1 parameter is supported on " +
                            responsePrefix + " methods",
                            [type.name, method.name, parameters.length]);
                    continue;
                }

                var parameter:Parameter = parameters[0];
                if (parameter.type.clazz is INotification) {
                    callbackType = CallbackType.WITH_NOTIFICATION;
                } else {
                    callbackType = CallbackType.WITH_BODY;
                }
            } else {
                callbackType = CallbackType.EMPTY;
            }
            var response:Response = createResponse(notificationName, this[method.name], callbackType);

            addResponse(response);
        }
    }
}
}
