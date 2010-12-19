package org.katasource.concoction.attributes {
import org.as3commons.lang.ClassUtils;
import org.as3commons.lang.StringUtils;
import org.as3commons.logging.ILogger;
import org.as3commons.logging.LoggerFactory;
import org.as3commons.reflect.MetaData;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ConstantAttributeSupport extends NameAttributeSupport implements IConstantAttribute {

    private var _nameField:String;

    public function ConstantAttributeSupport(nameClass:Class = null, nameField:String = null) {
        super(nameClass);

        _nameField = nameField;
    }

    public function get nameField():String {
        return _nameField;
    }

    public function set nameField(value:String):void {
        _nameField = value;
    }

    protected function getConstant():* {
        if (nameClass && StringUtils.hasText(nameField)) {
            try {
                return nameClass[nameField];
            } catch (e:*) {
                var logger:ILogger = LoggerFactory.getClassLogger(ConstantAttributeSupport);
                logger.error("[{0}] does not contain a constant named [{1}]",
                        [ClassUtils.getFullyQualifiedName(nameClass), nameField]);
            }
        }
        return null;
    }

    override protected function parseArguments(metadata:MetaData):void {
        super.parseArguments(metadata);

        nameField = getValue(metadata, "nameField");
    }
}
}
