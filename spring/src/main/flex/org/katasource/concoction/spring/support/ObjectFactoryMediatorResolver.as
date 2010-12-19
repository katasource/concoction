package org.katasource.concoction.spring.support {
import mx.containers.errors.ConstraintError;

import org.as3commons.lang.ClassUtils;
import org.as3commons.lang.ObjectUtils;
import org.as3commons.reflect.Type;
import org.katasource.concoction.attributes.MediatorAttribute;
import org.katasource.concoction.spring.view.DelegatingMediator;
import org.katasource.concoction.view.IMediator;
import org.katasource.concoction.view.support.IMediatorResolver;
import org.katasource.concoction.view.support.MediatorResolverSupport;
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

    public function resolveByMediatedComponent(mediatedComponent:*):* {
        var mediatorClass:Class = getMediatorClassFromView(mediatedComponent);

        return resolve(mediatorClass,
                      function(objectName:String):* {
                          return _objectFactory.getObject(objectName, [mediatedComponent]);
                      },
                      function():* {
                          return ClassUtils.newInstance(mediatorClass, [mediatedComponent]);
                      });
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

    protected function asMediator(object:*):IMediator {
        if (object is IMediator) {
            return object;
        } else {
            var type:Type = Type.forInstance(object);
            if (type.hasMetaData(MediatorAttribute.NAME)) {
                //This isn't an explicit mediator, but it can be coerced to be one. It has attributes applied which
                //allow Concoction to gather all of the necessary mediator configuration from the type itself.
                return new DelegatingMediator(object);
            }
        }
        return null;
    }

    protected function resolve(mediatorClass:Class, onOne:Function, onNone:Function):* {
        var mediatorDefinitions:Object = _objectFactory.getObjectsOfType(mediatorClass);

        var propertyNames:Array = ObjectUtils.getProperties(mediatorDefinitions);
        var object:*;
        if (propertyNames.length == 1) {
            object = onOne(propertyNames[0]);
        } else if (propertyNames.length == 0) {
            object = onNone();
        } else {
            throw new ConstraintError("[" + propertyNames.length + "] objects are configured for [" +
                    ClassUtils.getFullyQualifiedName(mediatorClass) + "]: " + propertyNames.join(", "));
        }

        var mediator:IMediator = asMediator(object);
        if (mediator) {
            return mediator;
        } else {
            throw new TypeError("[" + ClassUtils.getFullyQualifiedName(mediatorClass) +
                    "] is not a mediator, and cannot be coerced to a mediator type");
        }
    }
}
}
