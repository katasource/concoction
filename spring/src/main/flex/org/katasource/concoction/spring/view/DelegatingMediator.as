package org.katasource.concoction.spring.view {
import org.katasource.concoction.Reagent;
import org.katasource.concoction.lifecycle.IDisposable;
import org.katasource.concoction.lifecycle.IInitializable;
import org.katasource.concoction.note.INotificationRegistrar;
import org.katasource.concoction.spring.view.support.DelegateMediatorAttributeIntrospector;
import org.katasource.concoction.support.Response;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class DelegatingMediator extends Reagent implements IDelegatingMediator, IDisposable, IInitializable {

    private var _introspector:DelegateMediatorAttributeIntrospector;

    public function DelegatingMediator(delegate:*) {
        _introspector = new DelegateMediatorAttributeIntrospector(delegate);

        super(_introspector.mediatorName);
    }

    public function get delegate():* {
        return _introspector.mediator;
    }

    public function get mediatedComponent():* {
        return _introspector.mediatedComponent;
    }

    public function set mediatedComponent(value:*):void {
        _introspector.mediatedComponent = value;
    }

    public function dispose():void {
        _introspector.dispose();
    }

    public function initialize():void {
        _introspector.initialize();
    }

    public function registerNotifications(registrar:INotificationRegistrar):void {
        for each (var response:Response in _introspector.responses) {
            response.register(registrar);
        }
    }
}
}
