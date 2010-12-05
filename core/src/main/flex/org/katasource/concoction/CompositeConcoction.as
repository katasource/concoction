package org.katasource.concoction {
import org.katasource.concoction.lifecycle.IDisposable;
import org.katasource.concoction.model.DefaultModelManager;
import org.katasource.concoction.model.IModelManager;
import org.katasource.concoction.model.IProxy;
import org.katasource.concoction.note.DefaultNotifier;
import org.katasource.concoction.note.INotification;
import org.katasource.concoction.note.INotifier;
import org.katasource.concoction.note.Notification;
import org.katasource.concoction.view.DefaultViewManager;
import org.katasource.concoction.view.IMediator;
import org.katasource.concoction.view.IViewManager;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class CompositeConcoction extends Reagent implements IConcoction, IDisposable {

    private var _model:IModelManager;
    private var _notifier:INotifier;
    private var _view:IViewManager;

    public function CompositeConcoction() {
        _model = createModel();
        _notifier = createNotifier();
        _view = createView();
    }

    public function addMediator(mediator:IMediator):void {
        _view.addMediator(mediator);

        mediator.concoction = this;
    }

    public function addProxy(proxy:IProxy):void {
        _model.addProxy(proxy);

        proxy.concoction = this;
    }

    public function broadcast(notificationName:*, notificationBody:*):void {
        var notification:INotification = createNotification(notificationName, notificationBody);
        if (notification) {
            broadcastNotification(notification);
        }
    }

    public function broadcastNotification(notification:INotification):void {
        _notifier.sendNotification(notification);
    }

    public function dispose():void {
        if (_model is IDisposable) {
            IDisposable(_model).dispose();
        }
        if (_view is IDisposable) {
            IDisposable(_view).dispose();
        }
    }

    public function getMediator(name:String):IMediator {
        return _view.getMediator(name);
    }

    public function getProxy(name:String):IProxy {
        return _model.getProxy(name);
    }

    public function hasMediator(name:String):Boolean {
        return _view.hasMediator(name);
    }

    public function hasProxy(name:String):Boolean {
        return _model.hasProxy(name);
    }

    public function removeMediator(name:String):void {
        _view.removeMediator(name);
    }

    public function removeProxy(name:String):void {
        _model.removeProxy(name);
    }

    protected function createModel():IModelManager {
        return new DefaultModelManager();
    }

    protected function createNotification(name:*, body:*):INotification {
        return new Notification(name, body);
    }

    protected function createNotifier():INotifier {
        return new DefaultNotifier();
    }

    protected function createView():IViewManager {
        return new DefaultViewManager();
    }
}
}
