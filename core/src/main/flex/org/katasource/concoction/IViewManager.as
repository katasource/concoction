package org.katasource.concoction {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface IViewManager {

    function addMediator(mediator:IMediator):void;

    function getMediator(name:String):IMediator;

    function hasMediator(name:String):Boolean;
}
}
