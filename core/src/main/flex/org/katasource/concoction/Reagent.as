package org.katasource.concoction {
/**
 * @author Bryan Turner
 * @since 0.1
 */
public class Reagent implements IReagent {

    private var _concoction:IConcoction;
    private var _name:String;

    public function Reagent(name:String = null) {
        _name = name;
    }

    public function get concoction():IConcoction {
        return _concoction;
    }

    public function set concoction(value:IConcoction):void {
        _concoction = value;
    }

    public function get name():String {
        return _name;
    }
}
}
