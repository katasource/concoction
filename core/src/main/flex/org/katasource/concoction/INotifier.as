package org.katasource.concoction {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface INotifier {

    function broadcast(notification:INotification):void;
}
}
