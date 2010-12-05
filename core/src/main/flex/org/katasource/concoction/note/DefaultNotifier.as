package org.katasource.concoction.note {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public class DefaultNotifier implements INotifier {

    private var _listeners:Vector.<INotificationListener>;

    public function DefaultNotifier() {
        _listeners = new Vector.<INotificationListener>();
    }

    public function addListener(listener:INotificationListener):void {
        _listeners.push(listener);
    }

    public function sendNotification(notification:INotification):void {
        notify(notification, _listeners);
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
