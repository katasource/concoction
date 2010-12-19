package org.katasource.concoction.support {
import org.katasource.concoction.note.CallbackType;
import org.katasource.concoction.note.INotificationRegistrar;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class Response {

    private var _callback:Function;
    private var _notificationName:*;
    private var _type:CallbackType;

    public function Response(notificationName:*, callback:Function, type:CallbackType = null) {
        _callback = callback;
        _notificationName = notificationName;
        _type = type || CallbackType.AUTOMATIC;
    }

    public function get callback():Function {
        return _callback;
    }

    public function get notificationName():* {
        return _notificationName;
    }

    public function get type():CallbackType {
        return _type;
    }

    public function register(registrar:INotificationRegistrar):void {
        registrar.register(notificationName, callback, type)
    }
}
}
