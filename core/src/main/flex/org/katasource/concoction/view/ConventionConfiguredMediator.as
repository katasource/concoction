package org.katasource.concoction.view {
import org.katasource.concoction.lifecycle.IInitializable;
import org.katasource.concoction.support.Introspector;
import org.katasource.concoction.support.MemberIntrospector;
import org.katasource.concoction.view.support.MediatorMemberIntrospector;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ConventionConfiguredMediator extends IntrospectiveMediatorSupport implements IInitializable {

    public function ConventionConfiguredMediator(name:String = null, mediatedComponent:* = null, processResponses:Boolean = true, processReactions:Boolean = true) {
        super(name, mediatedComponent, processResponses, processReactions);
    }

    public function get reactionPrefix():String {
        return memberIntrospector.reactionPrefix;
    }

    public function get responsePrefix():String {
        return memberIntrospector.responsePrefix;
    }

    override protected function createIntrospector(processResponses:Boolean, processReactions:Boolean):Introspector {
        return new MediatorMemberIntrospector(this, mediatedComponent, processResponses, processReactions);
    }

    protected function get memberIntrospector():MemberIntrospector {
        return MemberIntrospector(introspector);
    }

    protected function setReactionPrefix(prefix:String):void {
        memberIntrospector.reactionPrefix = prefix;
    }

    protected function setResponsePrefix(prefix:String):void {
        memberIntrospector.responsePrefix = prefix;
    }
}
}
