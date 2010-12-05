package org.katasource.concoction.note {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public class Notification implements INotification {

    private var _body:*;
    private var _name:*;

    public function Notification(name:*, body:* = null) {
        _body = body;
        _name = name;
    }

    public function get body():* {
        return _body;
    }

    public function get name():String {
        return _name;
    }

    public function get rawName():* {
        return _name;
    }
}
}
