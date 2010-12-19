package org.katasource.concoction.view {
import org.as3commons.lang.IllegalArgumentError;
import org.as3commons.lang.IllegalStateError;
import org.as3commons.lang.StringUtils;
import org.katasource.concoction.Reagent;
import org.katasource.concoction.lifecycle.IDisposable;
import org.katasource.concoction.note.CallbackType;
import org.katasource.concoction.note.INotificationRegistrar;
import org.katasource.concoction.support.Response;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class MediatorAdapter extends Reagent implements IDisposable, IMediator {

    private var _registered:Boolean;
    private var _responses:Vector.<Response>;

    public function MediatorAdapter(name:String) {
        super(name);

        if (StringUtils.isBlank(name)) {
            throw new IllegalArgumentError("A name is required for MediatorAdapters, to allow multiple instances");
        }
        _responses = new Vector.<Response>();
    }

    public function get registered():Boolean {
        return _registered;
    }

    public function addResponse(notificationName:*, callback:Function, type:CallbackType = null):void {
        if (registered) {
            throw new IllegalStateError("MediatorAdapter [" + name + "] is already registered. " +
                    "New subscriptions can only be added before registration with Concoction");
        }
        _responses.push(new Response(notificationName, callback, type));
    }

    public function dispose():void {
        _responses = null;
    }

    public function registerNotifications(registrar:INotificationRegistrar):void {
        _registered = true;

        for each (var response:Response in _responses) {
            response.register(registrar);
        }
    }
}
}
