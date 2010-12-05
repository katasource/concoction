package org.katasource.concoction.note {
import asmock.framework.Expect;
import asmock.framework.MockRepository;
import asmock.framework.constraints.Is;

import org.flexunit.asserts.assertTrue;

/**
 * @author Bryan Turner
 * @since 0.1
 */
[RunWith("asmock.integration.flexunit.ASMockClassRunner")]
public class DefaultNotifierTest {

    [Mock]
    public static var mockClasses:Array = [INotificationListener];

    public function DefaultNotifierTest() {
    }

    [Test]
    public function testListenerActions():void {
        var repository:MockRepository = new MockRepository();

        var notification:INotification = new Notification("Name", "Body");

        var listener:INotificationListener = repository.createStrict(INotificationListener) as INotificationListener;
        Expect.call(listener.onNotification(null)).constraints([Is.same(notification)]);

        repository.replayAll();

        var notifier:DefaultNotifier = new DefaultNotifier();
        notifier.addListener(listener);
        notifier.sendNotification(notification);
        assertTrue(notifier.removeListener(listener));

        repository.verifyAll();
    }
}
}
