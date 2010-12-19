package org.katasource.concoction.attributes {
import org.as3commons.lang.IllegalStateError;
import org.as3commons.lang.StringUtils;
import org.as3commons.reflect.MetaData;
import org.as3commons.reflect.MetaDataContainer;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ReactionAttribute extends ConstantAttributeSupport {

    public static const NAME:String = "Reaction";

    private var _eventDispatcher:String;
    private var _eventType:String;
    private var _priority:int;
    private var _useCapture:Boolean;
    private var _useWeakReference:Boolean;

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

    public function get priority():int {
        return _priority;
    }

    public function set priority(value:int):void {
        _priority = value;
    }

    public function get useCapture():Boolean {
        return _useCapture;
    }

    public function set useCapture(value:Boolean):void {
        _useCapture = value;
    }

    public function get useWeakReference():Boolean {
        return _useWeakReference;
    }

    public function set useWeakReference(value:Boolean):void {
        _useWeakReference = value;
    }

    public static function fromContainer(container:MetaDataContainer):ReactionAttribute {
        var metadata:MetaData = getFirstMetaData(container, NAME);
        if (metadata == null) {
            return null;
        }
        return fromMetaData(metadata);
    }

    public static function fromMetaData(metadata:MetaData):ReactionAttribute {
        var attribute:ReactionAttribute = new ReactionAttribute();
        attribute.parseArguments(metadata);

        return attribute;
    }

    override protected function parseArguments(metadata:MetaData):void {
        eventDispatcher = getValue(metadata, "eventDispatcher");
        priority = getValueAsInt(metadata, "priority");
        useCapture = getValueAsBoolean(metadata, "useCapture");
        useWeakReference = getValueAsBoolean(metadata, "useWeakReference");

        var type:String = getValue(metadata, "eventType");
        if (StringUtils.hasText(type)) {
            eventType = type;
        } else {
            //If a concrete eventType property is not set, allow the base class to parse additional metadata
            //arguments and see if it is defined as a nameClass/nameField reference to a constant.
            super.parseArguments(metadata);

            var constant:* = getConstant();
            if (constant) {
                eventType = String(constant);
            } else {
                throw new IllegalStateError(NAME + " metadata does not define a valid event type");
            }
        }
    }
}
}
