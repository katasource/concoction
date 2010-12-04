package org.katasource.concoction.attributes {
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

    override protected function parseArguments(metadata:MetaData):void {
        super.parseArguments(metadata);

        nameField = getValue(metadata, "nameField");
    }
}
}
