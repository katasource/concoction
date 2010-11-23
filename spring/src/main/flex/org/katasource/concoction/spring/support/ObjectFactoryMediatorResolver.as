package org.katasource.concoction.spring.support {
import mx.containers.errors.ConstraintError;

import org.as3commons.lang.ClassUtils;
import org.as3commons.lang.ObjectUtils;
import org.katasource.concoction.support.IMediatorResolver;
import org.katasource.concoction.support.MediatorResolverSupport;
import org.springextensions.actionscript.ioc.factory.IListableObjectFactory;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ObjectFactoryMediatorResolver extends MediatorResolverSupport implements IMediatorResolver {

    private var _objectFactory:IListableObjectFactory;

    public function ObjectFactoryMediatorResolver(objectFactory:IListableObjectFactory) {
        _objectFactory = objectFactory;
    }

    public function resolveByType(mediatorClass:Class):* {
        return resolve(mediatorClass,
                      function(objectName:String):* {
                          return _objectFactory.getObject(objectName);
                      },
                      function():* {
                          return ClassUtils.newInstance(mediatorClass);
                      });
    }

    public function resolveByView(view:*):* {
        var mediatorClass:Class = getMediatorClassFromView(view);

        return resolve(mediatorClass,
                      function(objectName:String):* {
                          return _objectFactory.getObject(objectName, [view]);
                      },
                      function():* {
                          return ClassUtils.newInstance(mediatorClass, [view]);
                      });
    }

    protected function resolve(mediatorClass:Class, onOne:Function, onNone:Function):* {
        var mediatorDefinitions:Object = _objectFactory.getObjectsOfType(mediatorClass);

        var propertyNames:Array = ObjectUtils.getProperties(mediatorDefinitions);
        if (propertyNames.length == 1) {
            return onOne(propertyNames[0]);
        } else if (propertyNames.length == 0) {
            return onNone();
        } else {
            throw new ConstraintError("[" + propertyNames.length + "] objects are configured for [" +
                    ClassUtils.getFullyQualifiedName(mediatorClass) + "]: " + propertyNames.join(", "));
        }
    }
}
}
