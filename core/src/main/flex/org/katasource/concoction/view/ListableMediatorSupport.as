package org.katasource.concoction.view {
import org.katasource.concoction.note.CallbackType;
import org.katasource.concoction.note.INotification;
import org.katasource.concoction.note.INotificationRegistrar;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ListableMediatorSupport extends MediatorSupport implements IListableMediator {

    public function ListableMediatorSupport() {
    }

    public function getNotificationNames():Vector.<Object> {
        return new Vector.<Object>();
    }

    public function notify(notification:INotification):void {
        throw new Error("Derived ListableMediators must override notify(INotification)");
    }

    override public function registerNotifications(registrar:INotificationRegistrar):void {
        var notificationNames:Vector.<Object> = getNotificationNames();
        if (notificationNames && notificationNames.length > 0) {
            for each (var notificationName:Object in notificationNames) {
                registrar.register(notificationName, notify, CallbackType.WITH_NOTIFICATION);
            }
        }
    }
}
}
