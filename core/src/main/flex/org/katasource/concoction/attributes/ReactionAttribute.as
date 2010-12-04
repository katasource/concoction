package org.katasource.concoction.attributes {
import org.as3commons.reflect.MetaData;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ReactionAttribute extends ConstantAttributeSupport {

    private var _eventDispatcher:String;
    private var _eventType:String;

    public function ReactionAttribute() {
    }

    public function get eventDispatcher():String {
        return _eventDispatcher;
    }

    public function set eventDispatcher(value:String):void {
        _eventDispatcher = value;
    }

    public function get eventType():String {
        return _eventType;
    }

    public function set eventType(value:String):void {
        _eventType = value;
    }

    public static function fromMetaData(metadata:MetaData):ReactionAttribute {
        var attribute:ReactionAttribute = new ReactionAttribute();
        attribute.parseArguments(metadata);

        return attribute;
    }

    override protected function parseArguments(metadata:MetaData):void {
        super.parseArguments(metadata);

        eventDispatcher = getValue(metadata, "eventDispatcher");
        eventType = getValue(metadata, "eventType");
    }
}
}
