package org.katasource.concoction.note {
import org.as3commons.lang.ClassUtils;
import org.as3commons.lang.IllegalArgumentError;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class CallbackType {

    private static const DISCRIMINATOR:Discriminator = new Discriminator();

    public static const AUTOMATIC:CallbackType = new CallbackType("AUTOMATIC", AutomaticInvoker, _);
    public static const EMPTY:CallbackType = new CallbackType("EMPTY", EmptyInvoker, _);
    public static const WITH_BODY:CallbackType = new CallbackType("WITH_BODY", WithBodyInvoker, _);
    public static const WITH_NOTIFICATION:CallbackType = new CallbackType("WITH_NOTIFICATION", WithNotificationInvoker, _);

    private var _invoker:IInvoker;
    private var _name:String;

    public function CallbackType(name:String, invokerClass:Class, discriminator:* = null) {
        if (discriminator !== DISCRIMINATOR) {
            throw new IllegalArgumentError("CallbackType represents an enumeration and cannot be instantiated. " +
                    "Please use one of the constant values provided");
        }
        _invoker = ClassUtils.newInstance(invokerClass);
        _name = name;
    }

    public function get name():String {
        return _name;
    }

    public static function get values():Vector.<CallbackType> {
        var values:Vector.<CallbackType> = new Vector.<CallbackType>(4, true);
        values.push(AUTOMATIC, EMPTY, WITH_BODY, WITH_NOTIFICATION);

        return values;
    }

    public function invoke(callback:Function, notification:INotification):void {
        _invoker.invoke(callback, notification);
    }

    protected static function get _():Discriminator {
        return DISCRIMINATOR;
    }
}
}

import org.katasource.concoction.note.INotification;

class AutomaticInvoker implements IInvoker {

    public function invoke(callback:Function, notification:INotification):void {
        if (callback.length == 0) {
            callback();
        } else {
            callback(notification);
        }
    }
}

class Discriminator {

    public function Discriminator() {

    }
}

class EmptyInvoker implements IInvoker {

    public function invoke(callback:Function, notification:INotification):void {
        callback();
    }
}

interface IInvoker {
    function invoke(callback:Function, notification:INotification):void;
}

class WithBodyInvoker implements IInvoker {

    public function invoke(callback:Function, notification:INotification):void {
        callback(notification.body);
    }
}

class WithNotificationInvoker implements IInvoker {

    public function invoke(callback:Function, notification:INotification):void {
        callback(notification);
    }
}