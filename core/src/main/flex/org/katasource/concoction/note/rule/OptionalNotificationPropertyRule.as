package org.katasource.concoction.note.rule {
/**
 * {@link NotificationRule} for verifying an <i>optional</i> property when it is present.
 *
 * @author Bryan Turner
 * @since 0.1
 */
public class OptionalNotificationPropertyRule extends NotificationRule {

    private var _notificationName:String;

    public function OptionalNotificationPropertyRule(notificationName:String, propertyName:String, payloadClass:Class) {
        super(propertyName, payloadClass, true);
        _notificationName = notificationName;
    }

    public function get notificationName():String {
        return _notificationName;
    }

    override public function verifyBody(notificationPayload:Object):* {
        if (notificationPayload.hasOwnProperty(name)) {
            return super.verifyBody(notificationPayload[name]);
        }
        return notificationPayload;
    }

    override protected function getInvalidBodyClassErrorMessage(actualBodyClass:Class):String {
        return "Notification body (payload) contains an optional property named \"" + name +
                "\", which is required to be a " + bodyClass + " but was actually a " +
                actualBodyClass + " for notification \"" + notificationName + "\"";
    }
}
}