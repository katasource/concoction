package org.katasource.concoction.view.support {
import org.katasource.concoction.support.MemberIntrospector;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class MediatorMemberIntrospector extends MemberIntrospector {

    private var _mediatedComponent:*;
    private var _mediator:*;

    public function MediatorMemberIntrospector(mediator:*, mediatedComponent:* = null, processResponses:Boolean = true, processReactions:Boolean = true) {
        super(mediator, processResponses, processReactions);

        _mediatedComponent = mediatedComponent;
        _mediator = mediator;
    }
}
}
