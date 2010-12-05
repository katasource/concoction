package org.katasource.concoction.note {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public class CallbackMapNotificationListener implements INotificationListener {

    private var _map:Object;

    public function CallbackMapNotificationListener() {
        _map = {};
    }

    public function addCallback(notificationName:*, callback:Function, type:CallbackType = null):void {
        getListeners(notificationName).push(new CallbackNotificationListener(callback, type));
    }

    public function addCallbackListener(notificationName:*, listener:CallbackNotificationListener):void {
        getListeners(notificationName).push(listener);
    }

    public function onNotification(notification:INotification):void {
        var name:String = notification.name;
        if (_map.hasOwnProperty(name)) {
            var listeners:Vector.<CallbackNotificationListener> = _map[name];

            for each (var listener:CallbackNotificationListener in listeners) {
                listener.onNotification(notification);
            }
        }
    }

    public function removeCallback(notificationName:*, callback:Function):Boolean {
        return removeListener(notificationName, callback);
    }

    public function removeCallbackListener(notificationName:*, listener:CallbackNotificationListener):Boolean {
        return removeListener(notificationName, listener);
    }

    private function getListeners(notificationName:*):Vector.<CallbackNotificationListener> {
        var name:String = String(notificationName);

        var listeners:Vector.<CallbackNotificationListener>;
        if (_map.hasOwnProperty(name)) {
            listeners = _map[name];
        } else {
            listeners = new Vector.<CallbackNotificationListener>();

            _map[name] = listeners;
        }
        return listeners;
    }

    private function removeListener(notificationName:*, value:*):Boolean {
        var name:String = String(notificationName);
        if (_map.hasOwnProperty(name)) {
            var listeners:Vector.<CallbackNotificationListener> = _map[name];

            var listenerCount:uint = listeners.length;
            for (var i:uint = 0; i < listenerCount; ++i) {
                var listener:CallbackNotificationListener = listeners[i];
                if (listener.equals(value)) {
                    listeners.splice(i, 1);

                    return true;
                }
            }
        }
        return false;
    }
}
}
