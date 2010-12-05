package org.katasource.concoction.note {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface INotifier {

    function addListener(listener:INotificationListener):void;

    function sendNotification(notification:INotification):void;

    function removeListener(listener:INotificationListener):Boolean;
}
}
