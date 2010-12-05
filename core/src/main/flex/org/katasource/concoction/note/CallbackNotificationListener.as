package org.katasource.concoction.note {
import org.as3commons.lang.IEquals;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class CallbackNotificationListener implements IEquals, INotificationListener {

    private var _callback:Function;
    private var _type:CallbackType;

    public function CallbackNotificationListener(callback:Function, type:CallbackType = null) {
        _callback = callback;
        _type = type || CallbackType.AUTOMATIC;
    }

    public function get callback():Function {
        return _callback;
    }

    public function get type():CallbackType {
        return _type;
    }

    public function equals(other:Object):Boolean {
        return (other === this || other === callback);
    }

    public function onNotification(notification:INotification):void {
        type.invoke(_callback, notification);
    }
}
}
