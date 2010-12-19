package org.katasource.concoction.view {
import org.katasource.concoction.note.INotification;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface IListableMediator extends IMediator {

    function getNotificationNames():Vector.<Object>;

    function notify(notification:INotification):void;
}
}
