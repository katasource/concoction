package org.katasource.concoction.attributes {
import org.as3commons.reflect.MetaData;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ResponseAttribute extends ConstantAttributeSupport {

    private var _notificationName:String;

    public function ResponseAttribute() {
    }

    public function get notificationName():String {
        return _notificationName;
    }

    public function set notificationName(value:String):void {
        _notificationName = value;
    }

    public static function fromMetaData(metadata:MetaData):ResponseAttribute {
        var attribute:ResponseAttribute = new ResponseAttribute();
        attribute.parseArguments(metadata);

        return attribute;
    }

    override protected function parseArguments(metadata:MetaData):void {
        super.parseArguments(metadata);

        notificationName = getValue(metadata, "notificationName");
    }
}
}
