package org.katasource.concoction.note.rule {
/**
 * Internal property-level contract for {@code DynamicPayloadNotificationContract} properties.
 *
 * @author Bryan Turner
 * @since 0.1
 */
public class NotificationPropertyRule extends NotificationRule {

    private var _notificationName:String;

    public function NotificationPropertyRule(notificationName:String, propertyName:String, bodyClass:Class, allowNullBody:Boolean = false) {
        super(propertyName, bodyClass, allowNullBody);

        _notificationName = notificationName;
    }

    public function get notificationName():String {
        return _notificationName;
    }

    override public function verifyBody(notificationPayload:Object):* {
        //NOTE: Even if a dynamic property is allowed to be null, the dynamic property name must exist according to this
        //contract. If you want optional existence of the dynamic property, use OptionalNotificationPropertyRule.
        if (notificationPayload.hasOwnProperty(name)) {
            return super.verifyBody(notificationPayload[name]);
        }
        throw new Error(notificationName + ": Body requires a dynamic property named [" + name + "]");
    }

    override protected function getInvalidBodyClassErrorMessage(actualBodyClass:Class):String {
        return notificationName + ": Body requires the dynamic property named [" + name + "] to be an instance of " +
                getClassName(bodyClass) + " but it was an instance of " + getClassName(actualBodyClass);
    }

    override protected function getNullBodyErrorMessage():String {
        return notificationName + ": Body requires a non-null value for a dynamic property named [" + name + "]";
    }
}
}