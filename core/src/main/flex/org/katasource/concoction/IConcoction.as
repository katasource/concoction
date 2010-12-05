package org.katasource.concoction {
import org.katasource.concoction.model.IProxy;
import org.katasource.concoction.note.INotification;
import org.katasource.concoction.view.IMediator;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface IConcoction extends IReagent {

    function addMediator(mediator:IMediator):void;

    function addProxy(proxy:IProxy):void;

    function broadcast(notificationName:*, notificationBody:*):void;

    function broadcastNotification(notification:INotification):void;

    function getMediator(name:String):IMediator;

    function getProxy(name:String):IProxy;

    function hasMediator(name:String):Boolean;

    function hasProxy(name:String):Boolean;

    function removeMediator(name:String):void;

    function removeProxy(name:String):void;
}
}
