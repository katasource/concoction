package org.katasource.concoction.note {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface INotificationRegistrar {

    function register(notificationName:*, callback:Function, type:CallbackType = null):void;
}
}
