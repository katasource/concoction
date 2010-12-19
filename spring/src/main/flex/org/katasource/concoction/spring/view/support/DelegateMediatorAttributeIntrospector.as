package org.katasource.concoction.spring.view.support {
import org.as3commons.reflect.Accessor;
import org.as3commons.reflect.Field;
import org.as3commons.reflect.Variable;
import org.katasource.concoction.attributes.MediatedComponentAttribute;
import org.katasource.concoction.view.support.MediatorAttributeIntrospector;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class DelegateMediatorAttributeIntrospector extends MediatorAttributeIntrospector {

    private var _mediatedComponentField:Field;

    public function DelegateMediatorAttributeIntrospector(delegate:*) {
        super(delegate, null, true, true);
    }

    override public function get mediatedComponent():* {
        if (_mediatedComponentField) {
            return _mediatedComponentField.getValue(mediator);
        }
        return null;
    }

    public function set mediatedComponent(value:*):void {
        if (isWritable(_mediatedComponentField)) {
            mediator[_mediatedComponentField.name] = value;
        }
    }

    public function get mediatorClass():Class {
        return type.clazz;
    }

    public function get mediatorName():String {
        return type.name;
    }

    override public function initialize():void {
        //Before we allow the base class initialization, we first need to look for a [MediatedComponent]
        for each (var property:Field in type.properties) {
            if (property.hasMetaData(MediatedComponentAttribute.NAME)) {
                _mediatedComponentField = property;

                break;
            }
        }

        super.initialize();
    }

    protected function isWritable(field:Field):Boolean {
        if (field is Variable) {
            return true;
        } else if (field is Accessor) {
            return Accessor(field).isWriteable();
        }
        return false;
    }
}
}
