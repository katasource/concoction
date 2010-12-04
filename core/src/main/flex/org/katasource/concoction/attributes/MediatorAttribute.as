package org.katasource.concoction.attributes {
import org.as3commons.reflect.MetaData;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class MediatorAttribute extends NameAttributeSupport {

    public function MediatorAttribute() {
    }

    public static function fromMetaData(metadata:MetaData):MediatorAttribute {
        var attribute:MediatorAttribute = new MediatorAttribute();
        attribute.parseArguments(metadata);

        return attribute;
    }
}
}
