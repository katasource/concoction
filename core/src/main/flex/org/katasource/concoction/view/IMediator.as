package org.katasource.concoction.view {
import org.katasource.concoction.IReagent;
import org.katasource.concoction.note.INotificationRegistrar;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface IMediator extends IReagent {

    function registerNotifications(registrar:INotificationRegistrar):void;
}
}
