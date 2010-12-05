package org.katasource.concoction.rpc {
import flash.events.IEventDispatcher;

import mx.rpc.AbstractOperation;

import org.katasource.concoction.IReagent;

/**
 * Note: The majority of the methods on this interface are satisfied by the {@code mx.rpc.RemoteObject} class.
 */
public interface IService extends IEventDispatcher, IReagent {

    function get concurrency():String;

    function set concurrency(c:String):void;

    function get endpoint():String;

    function set endpoint(url:String):void;

    function get makeObjectsBindable():Boolean;

    function set makeObjectsBindable(b:Boolean):void;

    function get showBusyCursor():Boolean;

    function set showBusyCursor(sbc:Boolean):void;

    function get source():String;

    function set source(s:String):void;

    function getOperation(name:String):AbstractOperation

    function setRemoteCredentials(remoteUsername:String, remotePassword:String, charset:String = null):void

    function toString():String
}
}