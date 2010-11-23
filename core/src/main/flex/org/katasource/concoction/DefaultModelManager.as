package org.katasource.concoction {
import flash.utils.Dictionary;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class DefaultModelManager implements IModelManager {

    private var _proxies:Dictionary;

    public function DefaultModelManager() {
        _proxies = new Dictionary();
    }

    public function addProxy(proxy:IProxy):void {
        if (_proxies.hasOwnProperty(proxy.name)) {
            throw new ArgumentError("A proxy is already registered with name [" + proxy.name + "]");
        }
        _proxies[proxy.name] = proxy;
    }

    public function getProxy(name:String):IProxy {
        if (_proxies.hasOwnProperty(name)) {
            return _proxies[name];
        }
        return null;
    }

    public function hasProxy(name:String):Boolean {
        return _proxies.hasOwnProperty(name);
    }
}
}
