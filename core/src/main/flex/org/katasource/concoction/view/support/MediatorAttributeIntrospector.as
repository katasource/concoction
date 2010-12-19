package org.katasource.concoction.view.support {
import org.katasource.concoction.support.AttributeIntrospector;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class MediatorAttributeIntrospector extends AttributeIntrospector {

    private var _mediatedComponent:*;
    private var _mediator:*;

    public function MediatorAttributeIntrospector(mediator:*, mediatedComponent:* = null, processResponses:Boolean = true, processReactions:Boolean = true) {
        super(mediator, processResponses, processReactions);

        _mediatedComponent = mediatedComponent;
        _mediator = mediator;
    }

    public function get mediatedComponent():* {
        return _mediatedComponent;
    }

    public function get mediator():* {
        return _mediator;
    }
}
}
