package org.katasource.concoction.attributes {
import org.as3commons.lang.ClassUtils;
import org.as3commons.lang.StringUtils;
import org.as3commons.logging.ILogger;
import org.as3commons.logging.LoggerFactory;
import org.as3commons.reflect.MetaData;
import org.as3commons.reflect.MetaDataArgument;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class NameAttributeSupport implements INameAttribute {

    protected var logger:ILogger;
    private var _nameClass:Class;

    public function NameAttributeSupport(nameClass:Class = null) {
        _nameClass = nameClass;

        logger = LoggerFactory.getClassLogger(ClassUtils.forInstance(this));
    }

    public function get nameClass():Class {
        return _nameClass;
    }

    public function set nameClass(value:Class):void {
        _nameClass = value;
    }

    protected function getValue(metadata:MetaData, argumentName:String):String {
        var argument:MetaDataArgument = metadata.getArgument(argumentName);

        return argument ? argument.key : null;
    }

    protected function parseArguments(metadata:MetaData):void {
        var nameClassArgument:MetaDataArgument = metadata.getArgument("nameClass");
        if (nameClassArgument) {
            nameClass = parseNameClass(metadata.name, nameClassArgument.value);
        }
    }

    protected function parseNameClass(name:String, value:String):Class {
        if (StringUtils.isNotBlank(value)) {
            try {
                return ClassUtils.forName(value);
            } catch (e:Error) {
                //If we can't load the class, we log an error and then pretend a nameClass wasn't set.
                logger.warn("{0}.nameClass references {1}; the class could not be loaded", [name, value]);
            }
        }
        return null;
    }
}
}
