package org.katasource.concoction {
import flash.utils.Dictionary;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class DefaultNotifier implements INotifier {

    private var _rules:Dictionary;

    public function DefaultNotifier() {
        _rules = new Dictionary();
    }

    public function broadcast(notification:INotification):void {
        if (_rules.hasOwnProperty(notification.name)) {
            var handlers:Vector.<Function> = _rules[notification.name];
            for each (var handler:Function in handlers) {
                if (handler.length == 0) {
                    //If the handler does not accept any parameters, we invoke the handler directly. For framework
                    //users, this allows handlers which don't actually care about the content of the notification, but
                    //rather just care that the notification happened at all.
                    handler();
                } else {
                    //What I'd really like to do here is to determine whether the function wants the notification, or
                    //the notification's body. That would be a very useful shortcut for framework users. Unfortunately,
                    //it looks to me like there's no way to describe or introspect a function to find out about the
                    //parameters to the function. I'd love to learn the secret of that.
                    handler(notification);
                }
            }
        }
    }
}
}
