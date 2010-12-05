package org.katasource.concoction.view {
import org.katasource.concoction.IReagent;
import org.katasource.concoction.note.INotification;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface IMediator extends IReagent {

    function getSubscriptions():Vector.<String>;

    function notify(notification:INotification):void;
}
}
