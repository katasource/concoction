package org.katasource.concoction.view {
import org.as3commons.lang.StringUtils;
import org.as3commons.reflect.Method;
import org.as3commons.reflect.Type;
import org.katasource.concoction.lifecycle.IInitializable;
import org.katasource.concoction.note.INotification;
import org.katasource.concoction.support.Reaction;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ConventionMediator extends MediatorSupport implements IInitializable {

    public static const REACTION_PREFIX:String = "reactTo";
    public static const RESPONSE_PREFIX:String = "respondTo";

    private var _processReactions:Boolean;
    private var _processResponses:Boolean;
    private var _reactionPrefix:String;
    private var _responsePrefix:String;
    private var _subscriptions:Vector.<String>;

    public function ConventionMediator(name:String = null, processResponses:Boolean = true, processReactions:Boolean = true) {
        super(name);

        _processReactions = processReactions;
        _processResponses = processResponses;
        _reactionPrefix = REACTION_PREFIX;
        _responsePrefix = RESPONSE_PREFIX;
        _subscriptions = new Vector.<String>();
    }

    public function get processReactions():Boolean {
        return _processReactions;
    }

    public function set processReactions(value:Boolean):void {
        _processReactions = value;
    }

    public function get processResponses():Boolean {
        return _processResponses;
    }

    public function set processResponses(value:Boolean):void {
        _processResponses = value;
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

    override public function getSubscriptions():Vector.<String> {
        return _subscriptions;
    }

    public function initialize():void {
        var type:Type = Type.forInstance(this);

        processMethods(type);
    }

    override public function notify(notification:INotification):void {
        var methodName:String = responsePrefix + StringUtils.capitalize(notification.name);
        try {
            this[methodName](notification);
        } catch (e:Error) {
            //The response method is suddenly missing; that's kinda odd.
        }
    }

    protected function createAndAddReaction(method:Method):void {
        var reaction:Reaction = createReaction(method);
        if (reaction) {
            //addReaction(reaction);
        }
    }

    protected function createAndAddResponse(method:Method):void {
        var notificationName:String = extractNotificationName(method);
        if (notificationName) {
            _subscriptions.push(notificationName);
        }
    }

    protected function createReaction(method:Method):Reaction {
        return null;
    }

    protected function extractNotificationName(method:Method):String {
        return StringUtils.uncapitalize(method.name.substring(responsePrefix.length));
    }

    protected function isPrefixedBy(method:Method, prefix:String):Boolean {
        var name:String = method.name;

        return (name.length > prefix.length && StringUtils.startsWith(name, prefix));
    }

    protected function processMethod(method:Method):void {
        if (processReactions && isPrefixedBy(method, reactionPrefix)) {
            createAndAddReaction(method);
        } else if (processResponses && isPrefixedBy(method, responsePrefix)) {
            createAndAddResponse(method);
        }
    }

    protected function processMethods(type:Type):void {
        for each (var method:Method in type.methods) {
            processMethod(method);
        }
    }
}
}
