package org.katasource.concoction {
import flash.utils.Dictionary;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class DefaultNotifier implements INotifier {

    private var _callbacks:Dictionary;
    private var _listeners:Vector.<INotificationListener>;

    public function DefaultNotifier() {
        _callbacks = new Dictionary();
        _listeners = new Vector.<INotificationListener>();
    }

    public function addCallback(name:String, callback:Function):void {
        var callbacks:Vector.<INotificationListener>;
        if (_callbacks.hasOwnProperty(name)) {
            callbacks = _callbacks[name];
        } else {
            callbacks = new Vector.<INotificationListener>();
            _callbacks[name] = callbacks;
        }
        callbacks.push(new FunctionNotificationListener(callback));
    }

    public function addListener(listener:INotificationListener):void {
        _listeners.push(listener);
    }

    public function broadcast(notification:INotification):void {
        notify(notification, _listeners);

        if (_callbacks.hasOwnProperty(notification.name)) {
            var callbacks:Vector.<INotificationListener> = _callbacks[notification.name];

            notify(notification, callbacks);
        }
    }

    public function removeCallback(name:String, callback:Function):Boolean {
        if (_callbacks.hasOwnProperty(name)) {
            var callbacks:Vector.<INotificationListener> = _callbacks[name];
            for (var i:int = 0; i < callbacks.length; ++i) {
                if (FunctionNotificationListener(callbacks[i]).callback === callback) {
                    callbacks.splice(i, 1);

                    return true;
                }
            }
        }
        return false;
    }

    public function removeListener(listener:INotificationListener):Boolean {
        var index:Number = _listeners.indexOf(listener);
        if (index > -1) {
            _listeners.splice(index, 1);

            return true;
        }
        return false;
    }

    protected function notify(notification:INotification, listeners:Vector.<INotificationListener>):void {
        for each (var listener:INotificationListener in listeners) {
            listener.onNotification(notification);
        }
    }
}
}
