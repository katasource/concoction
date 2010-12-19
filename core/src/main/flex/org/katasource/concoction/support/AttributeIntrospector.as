package org.katasource.concoction.support {
import org.as3commons.reflect.Method;
import org.as3commons.reflect.Type;
import org.katasource.concoction.attributes.ReactionAttribute;
import org.katasource.concoction.attributes.ResponseAttribute;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class AttributeIntrospector extends Introspector {

    public function AttributeIntrospector(source:*, processResponses:Boolean = true, processReactions:Boolean = true) {
        super(source, processResponses, processReactions);
    }

    override protected function findReactionMethods():Vector.<Method> {
        return getMethodsByAttribute(ReactionAttribute.NAME);
    }

    override protected function findResponseMethods():Vector.<Method> {
        return getMethodsByAttribute(ResponseAttribute.NAME);
    }

    protected function getMethodsByAttribute(attributeName:String):Vector.<Method> {
        var type:Type = Type.forInstance(this);

        var methods:Vector.<Method> = new Vector.<Method>();
        for each (var method:Method in type.methods) {
            if (method.isStatic) {
                continue;
            }
            if (method.hasMetaData(attributeName)) {
                methods.push(method);
            }
        }
        return methods;
    }

    override protected function getNotificationName(method:Method):* {
        var attribute:ResponseAttribute = ResponseAttribute.fromContainer(method);

        var notificationName:*;
        if (attribute.hasNotificationName()) {
            notificationName = attribute.notificationName;
        } else {
            notificationName = method.name;
        }
        return notificationName;
    }

    override protected function processReactionMethods(reactionMethods:Vector.<Method>):void {
        for each (var method:Method in reactionMethods) {
            var attribute:ReactionAttribute = ReactionAttribute.fromContainer(method);


        }
    }
}
}
