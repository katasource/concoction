package org.katasource.concoction.note.rule {
import org.as3commons.lang.ClassUtils;
import org.katasource.concoction.note.INotification;

/**
 * Contract for Notification payload/body to help catch issues during unit tests or refactoring.
 *
 * @author Bryan Turner
 * @since 0.1
 */
public class NotificationRule implements INotificationRule {

    private var _allowNullBody:Boolean = false;
    private var _bodyClass:Class;
    private var _name:String;

    public function NotificationRule(name:String, bodyClass:Class, allowNullBody:Boolean = false) {
        _allowNullBody = allowNullBody;
        _bodyClass = bodyClass;
        _name = name;
    }

    public function get allowNullBody():Boolean {
        return _allowNullBody;
    }

    public function get bodyClass():Class {
        return _bodyClass;
    }

    public function get name():String {
        return _name;
    }

    public function toString():String {
        return name;
    }

    /** The verification that the given INotification's body (payload) satisfies this contract. */
    public function verifyBody(body:Object):* {
        if (body == null) {
            if (!allowNullBody) {
                throw new Error(getNullBodyErrorMessage());
            }
        } else if (!(body is bodyClass)) {
            throw new Error(getInvalidBodyClassErrorMessage(ClassUtils.forInstance(body)));
        }
        return body;
    }

    /** The verification that the given INotification satisfies this contract. */
    public function verifyNotification(notification:INotification):* {
        return verifyBody(notification.body);
    }

    protected function getClassName(clazz:Class):String {
        return ClassUtils.getFullyQualifiedName(clazz);
    }

    protected function getInvalidBodyClassErrorMessage(actualBodyClass:Class):String {
        return name + ": Body is required to be an instance of " + getClassName(bodyClass) +
                " but was actually " + getClassName(actualBodyClass);
    }

    protected function getNullBodyErrorMessage():String {
        return name + ": Body is required to be non-null, and an instance of " + getClassName(bodyClass);
    }
}
}