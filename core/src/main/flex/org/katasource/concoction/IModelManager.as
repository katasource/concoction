package org.katasource.concoction {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface IModelManager {

    function addProxy(proxy:IProxy):void;

    function getProxy(name:String):IProxy;

    function hasProxy(name:String):Boolean;
}
}
