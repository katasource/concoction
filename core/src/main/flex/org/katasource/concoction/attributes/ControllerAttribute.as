package org.katasource.concoction.attributes {
import org.as3commons.reflect.MetaData;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ControllerAttribute extends NameAttributeSupport {

    public static const NAME:String = "Controller";

    public function ControllerAttribute() {
    }

    public static function fromMetaData(metadata:MetaData):ControllerAttribute {
        var attribute:ControllerAttribute = new ControllerAttribute();
        attribute.parseArguments(metadata);

        return attribute;
    }
}
}
