package org.katasource.concoction.note.rule {
import org.katasource.concoction.note.INotification;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface INotificationRule {

    /** Whether or not the INotification is allowed to have a null body (payload) value. */
    function get allowNullBody():Boolean;

    /** The name of the INotification to which this INotificationContract applies. */
    function get name():String;

    function toString():String;

    /** The verification that the given INotification's body (payload) satisfies this contract. */
    function verifyBody(body:Object):*;

    /** The verification that the given INotification satisfies this contract. */
    function verifyNotification(notification:INotification):*;
}
}