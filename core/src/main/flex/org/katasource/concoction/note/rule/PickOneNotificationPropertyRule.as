package org.katasource.concoction.note.rule {
import org.katasource.concoction.note.INotification;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class PickOneNotificationPropertyRule implements INotificationRule {

    private var _rule:DynamicNotificationRule;
    private var _propertyRules:Vector.<INotificationRule>;
    private var _propertyNames:String;

    public function PickOneNotificationPropertyRule(contract:DynamicNotificationRule) {
        _rule = contract;
        _propertyRules = new Vector.<INotificationRule>();
    }

    public function get allowNullBody():Boolean {
        return _rule.allowNullBody;
    }

    public function get name():String {
        return _rule.name;
    }

    public function addOptionalProp(propName:String, propClass:Class):PickOneNotificationPropertyRule {
        _propertyRules.push(new OptionalNotificationPropertyRule(_rule.name, propName, propClass));

        return this;
    }

    public function addProp(propName:String, propClass:Class, allowNullValue:Boolean = false):PickOneNotificationPropertyRule {
        _propertyRules.push(new NotificationPropertyRule(_rule.name, propName, propClass, allowNullValue));

        return this;
    }

    public function done():DynamicNotificationRule {
        _propertyNames = _propertyRules.join(", ");

        return _rule;
    }

    public function toString():String {
        return name;
    }

    public function verifyBody(body:Object):* {
        //Loop over the defined properties registered for this contract
        var matchCount:int = 0;
        var matchNames:String = "";
        var requiredCount:int = 0;
        for each (var property:INotificationRule in _propertyRules) {
            if (property is DynamicNotificationRule) {
                ++requiredCount;
            }
            //For any property that exists on the payload
            if (body.hasOwnProperty(property.name)) {
                //Increment the match count
                ++matchCount;
                if (matchCount > 1) {
                    matchNames += ", ";
                }
                //Add the property name to the list of matched property names
                matchNames += property.name;

                //Verify that the property has the required value
                property.verifyBody(body);
            }
        }

        if (matchCount == 0 && requiredCount > 0) {
            //If none of the properties was matched, they didn't pick one
            throw new Error(name + ": Body requires one dynamic property from \"" + _propertyNames +
                    "\" to be provided for notification \"" + name + "\"");
        } else if (matchCount > 1) {
            //If multiple properties were matched, they picked too many
            throw new Error("Notification body (payload) contains properties \"" + matchNames +
                    "\", but only one of these may be provided at a time for notification \"" + name + "\"");
        }
        return body;
    }

    public function verifyNotification(notification:INotification):* {
        return _rule.verifyNotification(notification);
    }
}
}