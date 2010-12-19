package org.katasource.concoction.attributes {
import org.as3commons.lang.StringUtils;
import org.as3commons.reflect.MetaData;
import org.as3commons.reflect.MetaDataContainer;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ResponseAttribute extends ConstantAttributeSupport {

    public static const NAME:String = "Response";

    private var _notificationName:*;

    public function ResponseAttribute() {
    }

    public function get notificationName():* {
        return _notificationName;
    }

    public function set notificationName(value:*):void {
        _notificationName = value;
    }

    public function hasNotificationName():Boolean {
        return (notificationName != null);
    }

    public static function fromContainer(container:MetaDataContainer):ResponseAttribute {
        var metadata:MetaData = getFirstMetaData(container, NAME);
        if (metadata == null) {
            return null;
        }
        return fromMetaData(metadata);
    }

    public static function fromMetaData(metadata:MetaData):ResponseAttribute {
        var attribute:ResponseAttribute = new ResponseAttribute();
        attribute.parseArguments(metadata);

        return attribute;
    }

    override protected function parseArguments(metadata:MetaData):void {
        var name:String = getValue(metadata, "notificationName");
        if (StringUtils.hasText(name)) {
            notificationName = name;
        } else {
            //If a concrete notificationName property is not set, allow the base class to parse additional metadata
            //arguments and see if it is defined as a nameClass/nameField reference to a constant.
            super.parseArguments(metadata);

            notificationName = getConstant();
        }
    }
}
}
