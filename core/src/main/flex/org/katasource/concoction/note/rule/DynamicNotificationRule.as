package org.katasource.concoction.note.rule {
import org.katasource.concoction.note.INotification;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class DynamicNotificationRule implements INotificationRule {

    private var _allowNullBody:Boolean = false;
    private var _bodyPropertyRules:Vector.<INotificationRule>;
    private var _name:String;

    public function DynamicNotificationRule(name:String, allowNullBody:Boolean = false):void {
        _allowNullBody = allowNullBody;
        _bodyPropertyRules = new Vector.<INotificationRule>();
        _name = name;
    }

    public function get allowNullBody():Boolean {
        return _allowNullBody;
    }

    public function get name():String {
        return _name;
    }

    public function addOptionalProp(propertyName:String, propertyClass:Class):DynamicNotificationRule {
        _bodyPropertyRules.push(new OptionalNotificationPropertyRule(name, propertyName, propertyClass));

        return this;
    }

    /**
     * Add a contract that the given property name exists in an {@code INotification}, and is of the given {@code Class}
     */
    public function addProp(propertyName:String, propertyClass:Class, allowNullValue:Boolean = false):DynamicNotificationRule {
        _bodyPropertyRules.push(new NotificationPropertyRule(name, propertyName, propertyClass, allowNullValue));

        return this;
    }

    public function createPickOneProp():PickOneNotificationPropertyRule {
        var contract:PickOneNotificationPropertyRule = new PickOneNotificationPropertyRule(this);
        _bodyPropertyRules.push(contract);

        return contract;
    }

    public function toString():String {
        return name;
    }

    /** The verification that the given INotification's body (payload) satisfies this contract. */
    public function verifyBody(notificationPayload:Object):* {
        if (notificationPayload == null) {
            if (!allowNullBody) {
                throw new Error(name + ": Body is required to be non-null");
            }
        } else {
            // verify all expected dynamic property objects exist and are of the correct Class
            for each (var rule:INotificationRule in _bodyPropertyRules) {
                rule.verifyBody(notificationPayload);
            }
        }
        return notificationPayload;
    }

    /** The verification that the given INotification satisfies this contract. */
    public function verifyNotification(notification:INotification):* {
        return verifyBody(notification.body);
    }
}
}