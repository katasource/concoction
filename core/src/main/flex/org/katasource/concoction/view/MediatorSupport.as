package org.katasource.concoction.view {
import org.as3commons.lang.ClassUtils;
import org.katasource.concoction.IConcoction;
import org.katasource.concoction.lifecycle.IDisposable;
import org.katasource.concoction.note.INotification;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class MediatorSupport implements IDisposable, IMediator {

    private var _children:Vector.<IMediator>;
    private var _concoction:IConcoction;
    private var _name:String;

    public function MediatorSupport(name:String = null) {
        _children = new Vector.<IMediator>();
        _name = name || ClassUtils.getFullyQualifiedName(ClassUtils.forInstance(this), true);
    }

    public function get children():Vector.<IMediator> {
        return _children.slice();
    }

    public function get concoction():IConcoction {
        return _concoction;
    }

    public function set concoction(value:IConcoction):void {
        _concoction = value;
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }

    public function dispose():void {
        if (concoction) {
            for each (var mediator:IMediator in _children) {
                concoction.removeMediator(mediator.name);
            }
        }
    }

    public function addMediator(mediator:IMediator):void {
        _children.push(mediator);

        if (concoction) {
            concoction.addMediator(mediator);
        }
    }

    public function getSubscriptions():Vector.<String> {
        return new Vector.<String>();
    }

    public function removeMediator(name:String):void {
        for (var i:int = 0; i < _children.length; ++i) {
            var mediator:IMediator = _children[i];
            if (mediator.name == name) {
                _children.splice(i, 1);

                break;
            }
        }

        if (concoction) {
            concoction.removeMediator(mediator.name);
        }
    }

    public function notify(notification:INotification):void {
        throw new Error("Derived Mediators must override respondToNotification(INotification)");
    }
}
}
