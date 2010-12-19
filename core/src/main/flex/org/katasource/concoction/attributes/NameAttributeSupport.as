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
public class NameAttributeSupport extends AttributeSupport implements INameAttribute {

    private var _nameClass:Class;

    public function NameAttributeSupport(nameClass:Class = null) {
        _nameClass = nameClass;
    }

    public function get nameClass():Class {
        return _nameClass;
    }

    public function set nameClass(value:Class):void {
        _nameClass = value;
    }

    protected function getValue(metadata:MetaData, argumentName:String):String {
        var argument:MetaDataArgument = metadata.getArgument(argumentName);

        return (argument ? argument.value : null);
    }

    protected function getValueAsBoolean(metadata:MetaData, argumentName:String):Boolean {
        var value:String = getValue(metadata, argumentName);
        if (value) {
            return StringUtils.equalsIgnoreCase("true", value);
        }
        return false;
    }

    protected function getValueAsInt(metadata:MetaData, argumentName:String):int {
        var value:String = getValue(metadata, argumentName);
        if (value) {
            if (StringUtils.isNumeric(value)) {
                return int(value);
            } else {
                var logger:ILogger = LoggerFactory.getClassLogger(NameAttributeSupport);
                logger.warn("{0}.{1} ({2}) cannot be interpreted as an int",
                        [metadata.name, argumentName, value])
            }
        }
        return 0;
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
                var logger:ILogger = LoggerFactory.getClassLogger(NameAttributeSupport);
                logger.warn("{0}.nameClass references {1}; the class could not be loaded", [name, value]);
            }
        }
        return null;
    }
}
}
