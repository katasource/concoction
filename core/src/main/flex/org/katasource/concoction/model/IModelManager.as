package org.katasource.concoction.model {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface IModelManager {

    function addProxy(proxy:IProxy):void;

    function getProxy(name:String):IProxy;

    function hasProxy(name:String):Boolean;

    function removeProxy(name:String):void;
}
}
