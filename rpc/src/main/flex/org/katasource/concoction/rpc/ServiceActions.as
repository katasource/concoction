package org.katasource.concoction.rpc {
import mx.messaging.messages.IMessage;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;

import org.katasource.concoction.note.rule.DynamicNotificationRule;

public class ServiceActions {

    public static const SERVICE_INVOCATION_COMPLETE:* = createRule("serviceInvocationComplete")
            .addProp("result", ResultEvent);
    public static const SERVICE_INVOCATION_FAILED:* = createRule("serviceInvocationFailed")
            .addProp("fault", FaultEvent);
    public static const SERVICE_INVOCATION_STARTED:* = createRule("serviceInvocationStarted");
    public static const SERVICE_INVOCATION_STARTING:* = createRule("serviceInvocationStarting");

    private static function createRule(notificationName:String):DynamicNotificationRule {
        return new DynamicNotificationRule(notificationName)
                .addProp("correlationId", String).addProp("destination", String)
                .addProp("messageId", String).addProp("message", IMessage)
                .addProp("operation", String);
    }
}
}