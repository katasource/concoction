package org.katasource.concoction.note {
import org.as3commons.lang.IEquals;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class FunctionNotificationListener implements IEquals, INotificationListener {

    private var _callback:Function;

    public function FunctionNotificationListener(callback:Function) {
        _callback = callback;
    }

    public function get callback():Function {
        return _callback;
    }

    public function equals(other:Object):Boolean {
        return (other === this || other === callback);
    }

    public function onNotification(notification:INotification):void {
        if (_callback.length == 0) {
            //If the handler does not accept any parameters, we invoke the handler directly. For framework
            //users, this allows handlers which don't actually care about the content of the notification, but
            //rather just care that the notification happened at all.
            _callback();
        } else {
            //What I'd really like to do here is to determine whether the function wants the notification, or
            //the notification's body. That would be a very useful shortcut for framework users. Unfortunately,
            //it looks to me like there's no way to describe or introspect a function to find out about the
            //parameters to the function. I'd love to learn the secret of that.
            _callback(notification);
        }
    }
}
}
