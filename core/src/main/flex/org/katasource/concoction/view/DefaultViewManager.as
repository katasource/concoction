package org.katasource.concoction.view {
import flash.utils.Dictionary;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class DefaultViewManager implements IViewManager {

    private var _mediators:Dictionary;

    public function DefaultViewManager() {
        _mediators = new Dictionary()
    }

    public function addMediator(mediator:IMediator):void {
        if (_mediators.hasOwnProperty(mediator)) {
            throw new ArgumentError("A mediator is already registered with name [" + mediator.name + "]");
        }
        _mediators[mediator.name] = mediator;
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
        if (_mediators.hasOwnProperty(name)) {
            delete _mediators[name];
        }
    }
}
}