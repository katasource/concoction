package org.katasource.concoction.spring {
import flash.errors.IllegalOperationError;

import org.katasource.concoction.model.IModelManager;
import org.katasource.concoction.model.IProxy;
import org.springextensions.actionscript.ioc.factory.config.IConfigurableListableObjectFactory;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ObjectFactoryModelManager implements IModelManager {

    private var _objectFactory:IConfigurableListableObjectFactory;

    public function ObjectFactoryModelManager(objectFactory:IConfigurableListableObjectFactory) {
        _objectFactory = objectFactory;
    }

    public function addProxy(proxy:IProxy):void {
        _objectFactory.registerSingleton(proxy.name, proxy);
    }

    public function getProxy(name:String):IProxy {
        var object:* = _objectFactory.getObject(name);
        if (object is IProxy) {
            return object;
        }
        throw new TypeError("[" + name + "] does not reference an IProxy instance");
    }

    public function hasProxy(name:String):Boolean {
        return _objectFactory.containsObject(name);
    }

    public function removeProxy(name:String):void {
        throw new IllegalOperationError("The Spring ObjectFactoryModelManager does not support removing proxies");
    }
}
}
