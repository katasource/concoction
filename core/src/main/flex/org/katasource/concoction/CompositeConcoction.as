package org.katasource.concoction {
import org.katasource.concoction.lifecycle.IDisposable;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class CompositeConcoction extends Reagent implements IConcoction, IDisposable {

    private var _model:IModel;
    private var _notifier:INotifier;
    private var _view:IView;

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

    public function broadcast(notification:INotification):void {
        _notifier.broadcast(notification);
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

    protected function createModel():IModel {
        return new DefaultModel();
    }

    protected function createNotifier():INotifier {
        return new DefaultNotifier();
    }

    protected function createView():IView {
        return new DefaultView();
    }
}
}
