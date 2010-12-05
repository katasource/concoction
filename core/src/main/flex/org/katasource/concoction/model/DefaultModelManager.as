package org.katasource.concoction.model {


/**
 * @author Bryan Turner
 * @since 0.1
 */
public class DefaultModelManager implements IModelManager {

    private var _proxies:Object;

    public function DefaultModelManager() {
        _proxies = {};
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

    public function removeProxy(name:String):void {
        if (_proxies.hasOwnProperty(name)) {
            delete _proxies[name];
        }
    }
}
}
