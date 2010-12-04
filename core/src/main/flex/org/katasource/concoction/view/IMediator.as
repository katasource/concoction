package org.katasource.concoction.view {
import org.katasource.concoction.INotification;
import org.katasource.concoction.IReagent;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface IMediator extends IReagent {

    function getSubscriptions():Vector.<String>;

    function notify(notification:INotification):void;
}
}
