package org.katasource.concoction.lifecycle {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public class Lifecycle {

    public function Lifecycle(lock:*) {
        throw new Error("Lifecycle is a static utility class and cannot be instantiated");
    }

    public static function dispose(object:*):void {
        if (object is IDisposable) {
            IDisposable(object).dispose();
        }
    }

    public static function initialize(object:*):void {
        if (object is IInitializable) {
            IInitializable(object).initialize();
        }
    }
}
}
