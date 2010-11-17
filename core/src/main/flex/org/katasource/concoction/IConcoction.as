package org.katasource.concoction {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface IConcoction extends IReagent {

    function addMediator(mediator:IMediator):void;

    function addProxy(proxy:IProxy):void;

    function broadcast(notification:INotification):void;

    function getMediator(name:String):IMediator;

    function getProxy(name:String):IProxy;

    function hasMediator(name:String):Boolean;

    function hasProxy(name:String):Boolean;
}
}
