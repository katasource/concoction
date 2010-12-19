package org.katasource.concoction.view {
import org.katasource.concoction.lifecycle.Lifecycle;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class DefaultViewManager implements IViewManager {

    private var _mediators:Object;

    public function DefaultViewManager() {
        _mediators = {};
    }

    public function addMediator(mediator:IMediator):void {
        if (_mediators.hasOwnProperty(mediator)) {
            throw new ArgumentError("A mediator is already registered with name [" + mediator.name + "]");
        }
        _mediators[mediator.name] = mediator;

        Lifecycle.initialize(mediator);
    }

    public function getMediator(name:String):IMediator {
        if (_mediators.hasOwnProperty(name)) {
            return _mediators[name];
        }
        return null;
    }

    public function hasMediator(name:String):Boolean {
        return _mediators.hasOwnProperty(name);
    }

    public function removeMediator(name:String):void {
        var mediator:IMediator = getMediator(name);
        if (mediator) {
            delete _mediators[name];

            Lifecycle.dispose(mediator);
        }
    }
}
}

import org.katasource.concoction.view.IMediator;

class Wrapper {

    private var _mediator:IMediator;

    public function Wrapper() {
    }
}