package org.katasource.concoction.view {
import org.katasource.concoction.lifecycle.IInitializable;
import org.katasource.concoction.support.Introspector;
import org.katasource.concoction.view.support.MediatorAttributeIntrospector;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class AttributeConfiguredMediator extends IntrospectiveMediatorSupport implements IInitializable {

    public function AttributeConfiguredMediator(name:String = null, mediatedComponent:* = null, processResponses:Boolean = true, processReactions:Boolean = true) {
        super(name, mediatedComponent, processResponses, processReactions);
    }

    override protected function createIntrospector(processResponses:Boolean, processReactions:Boolean):Introspector {
        return new MediatorAttributeIntrospector(this, mediatedComponent, processResponses, processReactions);
    }
}
}
