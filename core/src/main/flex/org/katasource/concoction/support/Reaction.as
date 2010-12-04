package org.katasource.concoction.support {
import flash.events.IEventDispatcher;

import org.katasource.concoction.lifecycle.IDisposable;
import org.katasource.concoction.lifecycle.IInitializable;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class Reaction implements IDisposable, IInitializable {

    private var _eventDispatcher:IEventDispatcher;
    private var _listener:Function;
    private var _priority:int;
    private var _type:String;
    private var _useCapture:Boolean;
    private var _useWeakReference:Boolean;

    public function Reaction(eventDispatcher:IEventDispatcher, type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) {
        _eventDispatcher = eventDispatcher;
        _listener = listener;
        _priority = priority;
        _type = type;
        _useCapture = useCapture;
        _useWeakReference = useWeakReference;
    }

    public function get eventDispatcher():IEventDispatcher {
        return _eventDispatcher;
    }

    public function get listener():Function {
        return _listener;
    }

    public function get priority():int {
        return _priority;
    }

    public function get type():String {
        return _type;
    }

    public function get useCapture():Boolean {
        return _useCapture;
    }

    public function get useWeakReference():Boolean {
        return _useWeakReference;
    }

    public function dispose():void {
        _eventDispatcher.removeEventListener(type, listener);
    }

    public function initialize():void {
        _eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }
}
}
