package org.katasource.concoction.view {
import org.as3commons.lang.ClassUtils;
import org.katasource.concoction.IConcoction;
import org.katasource.concoction.lifecycle.IDisposable;
import org.katasource.concoction.note.INotificationRegistrar;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class MediatorSupport implements IDisposable, IMediator {

    private var _children:Vector.<ChildMediator>;
    private var _concoction:IConcoction;
    private var _mediatedComponent:*;
    private var _name:String;

    public function MediatorSupport(name:String = null, mediatedComponent:* = null) {
        _children = new Vector.<ChildMediator>();
        _mediatedComponent = mediatedComponent;
        _name = name || ClassUtils.getFullyQualifiedName(ClassUtils.forInstance(this), true);
    }

    public function get children():Vector.<IMediator> {
        var children:Vector.<IMediator> = new Vector.<IMediator>(_children.length, true);
        for each (var child:ChildMediator in _children) {
            children.push(child.mediator);
        }
        return children;
    }

    public function get concoction():IConcoction {
        return _concoction;
    }

    public function set concoction(value:IConcoction):void {
        _concoction = value;

        for each (var child:ChildMediator in _children) {
            child.register(value);
        }
    }

    public function get mediatedComponent():* {
        return _mediatedComponent;
    }

    public function set mediatedComponent(value:*):void {
        _mediatedComponent = value;
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }

    public function dispose():void {
        if (concoction) {
            for each (var child:ChildMediator in _children) {
                child.unregister();
            }
            _children = null;
        }
    }

    public function addMediator(mediator:IMediator):void {
        var child:ChildMediator = new ChildMediator(mediator);
        if (concoction) {
            child.register(concoction);
        }
        _children.push(child);
    }

    public function registerNotifications(registrar:INotificationRegistrar):void {
        //Default behavior assumes no notifications, since there's not much we can assume.
    }

    public function removeMediator(name:String):void {
        for (var i:int = 0; i < _children.length; ++i) {
            var child:ChildMediator = _children[i];
            if (child.equals(name)) {
                child.unregister();

                _children.splice(i, 1);
                break;
            }
        }
    }
}
}

import org.as3commons.lang.IEquals;
import org.as3commons.lang.StringUtils;
import org.katasource.concoction.IConcoction;
import org.katasource.concoction.view.IMediator;

class ChildMediator implements IEquals {

    private var _concoction:IConcoction;
    private var _mediator:IMediator;

    public function ChildMediator(mediator:IMediator) {
        _mediator = mediator;
    }

    public function get mediator():IMediator {
        return _mediator;
    }

    public function equals(other:Object):Boolean {
        var mediatorName:String = (other is IMediator ? IMediator(other).name : String(other));

        return StringUtils.equals(mediatorName, mediator.name);
    }

    public function register(concoction:IConcoction):void {
        unregister();

        _concoction = concoction;
        _concoction.addMediator(_mediator);
    }

    public function unregister():void {
        if (_concoction) {
            _concoction.removeMediator(_mediator.name);
        }
    }
}