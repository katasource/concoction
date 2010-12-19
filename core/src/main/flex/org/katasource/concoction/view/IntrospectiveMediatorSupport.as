package org.katasource.concoction.view {
import org.as3commons.lang.IllegalStateError;
import org.katasource.concoction.lifecycle.IInitializable;
import org.katasource.concoction.note.INotificationRegistrar;
import org.katasource.concoction.support.Introspector;
import org.katasource.concoction.support.Reaction;
import org.katasource.concoction.support.Response;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class IntrospectiveMediatorSupport extends MediatorSupport implements IInitializable {

    private var _introspector:Introspector;

    public function IntrospectiveMediatorSupport(name:String = null, mediatedComponent:* = null, processResponses:Boolean = true, processReactions:Boolean = true) {
        super(name, mediatedComponent);

        _introspector = createIntrospector(processResponses, processReactions);
    }

    public function get processReactions():Boolean {
        return _introspector.processReactions;
    }

    public function get processResponses():Boolean {
        return _introspector.processResponses;
    }

    override public function dispose():void {
        super.dispose();

        _introspector.dispose();
    }

    public function initialize():void {
        _introspector.initialize();

        if (processReactions) {
            for each (var reaction:Reaction in _introspector.reactions) {
                reaction.initialize();
            }
        }
    }

    override public function registerNotifications(registrar:INotificationRegistrar):void {
        if (processResponses) {
            for each (var response:Response in _introspector.responses) {
                response.register(registrar);
            }
        }
    }

    protected function get introspector():Introspector {
        return _introspector;
    }

    protected function createIntrospector(processResponses:Boolean, processReactions:Boolean):Introspector {
        throw new IllegalStateError("Derived IntrospectiveMediators must override createIntrospector");
    }
}
}
