package org.katasource.concoction.rpc {
import mx.core.mx_internal;
import mx.managers.CursorManager;
import mx.messaging.events.MessageEvent;
import mx.messaging.messages.AsyncMessage;
import mx.messaging.messages.IMessage;
import mx.rpc.AbstractService;
import mx.rpc.AsyncToken;
import mx.rpc.Responder;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.mxml.Concurrency;
import mx.rpc.remoting.Operation;

import org.katasource.concoction.IConcoction;
import org.katasource.concoction.IReagent;

use namespace mx_internal;

/**
 * An extension of the standard Flex remoting {@code Operation} which allows Concoction framework elements to
 * react to and alter service invocations by dispatching notifications related to service actions.
 * <ul>
 * <li>{@code SERVICE_INVOCATION_COMPLETE}</li>
 * <li>{@code SERVICE_INVOCATION_FAILED}</li>
 * <li>{@code SERVICE_INVOCATION_STARTED}</li>
 * <li>{@code SERVICE_INVOCATION_STARTING}</li>
 * </ul>
 * If no {@link IConcoction concoction} is available, this operation behaves identically to the base {@code Operation}
 * class.
 *
 * @author Bryan Turner
 * @since 0.1
 */
public class ServiceOperation extends Operation implements IReagent {

    private var _concoction:IConcoction;

    public function ServiceOperation(remoteObject:AbstractService, name:String, concoction:IConcoction = null) {
        super(remoteObject, name);

        _concoction = concoction;
    }

    public function get concoction():IConcoction {
        return _concoction;
    }

    public function set concoction(value:IConcoction):void {
        _concoction = value;
    }

    mx_internal override function invoke(message:IMessage, token:AsyncToken = null):AsyncToken {
        if (concoction) {
            notify(ServiceActions.SERVICE_INVOCATION_STARTING, createNotificationBody(message, false));
        }
        token = super.invoke(message);
        if (concoction) {
            token.addResponder(new Responder(onResult, onFault));

            notify(ServiceActions.SERVICE_INVOCATION_STARTED, createNotificationBody(message, false));
        }
        return token;
    }

    protected function get destination():String {
        return service.destination;
    }

    protected function createNotificationBody(message:IMessage, withCorrelation:Boolean = true):Object {
        return {correlationId: (withCorrelation ? getCorrelationId(message) : message.messageId),
            destination: destination, messageId: message.messageId, message: message, operation: name};
    }

    protected function getCorrelationId(message:IMessage):String {
        try {
            return message["correlationId"];
        } catch (e:Error) {
            //Not all IMessage implementations have a correlationId property on them. For those that do, it is the
            //preferred ID to use for notifications. However, if the message does not have one, we fall back on the
            //message's messageId property instead.
        }
        return message.messageId;
    }

    protected function notify(notificationName:*, notificationBody:Object):void {
        //Send the notification on whatever concoction this operation is attached to
        concoction.broadcast(notificationName, notificationBody);
    }

    protected function onFault(event:FaultEvent):void {
        var body:Object = createNotificationBody(event.message);
        body.fault = event.fault;

        notify(ServiceActions.SERVICE_INVOCATION_FAILED, body);
    }

    protected function onResult(event:ResultEvent):void {
        var body:Object = createNotificationBody(event.message);
        body.result = event.result;

        notify(ServiceActions.SERVICE_INVOCATION_COMPLETE, body);
    }

    /*
     * This method is overridden to suppress a bug in the default implementation for concurrency in {@code Operation}.
     * <p/>
     * The bug is characterized by the following set of behaviors:
     * <ol>
     * <li>Request A is sent</li>
     * <li>Request B is sent</li>
     * <li>B returns a response</li>
     * <li>"wasLastCall" is true for response B because it is the last item in the activeCalls.callOrder list</li>
     * <li>B is removed from the activeCalls.callOrder list</li>
     * <li>A returns a response</li>
     * <li>"wasLastCall" is true for response A because it is now the last item in the activeCalls.callOrder list</li>
     * <li>A is removed from the activeCalls.callOrder list</li>
     * </ol>
     * Any time all responses return in exactly the opposite order in which they were sent, this bug will manifest in
     * the default Operation code.
     */
    override mx_internal function preHandle(event:MessageEvent):AsyncToken {
        if (showBusyCursor) {
            CursorManager.removeBusyCursor();
        }

        var wasLastCall:Boolean = activeCalls.wasLastCall(AsyncMessage(event.message).correlationId);
        var token:AsyncToken = super.preHandle(event);

        if (Concurrency.LAST == concurrency) {
            if (wasLastCall) {
                var dropped:int = 0;
                while (activeCalls.cancelLast() != null) {
                    ++dropped;
                }
            } else {
                return null;
            }
        }
        return token;
    }
}
}