package org.katasource.concoction {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface INotifier {

    function addCallback(name:String, callback:Function):void;

    function addListener(listener:INotificationListener):void;

    function broadcast(notification:INotification):void;

    function removeCallback(name:String, callback:Function):Boolean;

    function removeListener(listener:INotificationListener):Boolean;
}
}
