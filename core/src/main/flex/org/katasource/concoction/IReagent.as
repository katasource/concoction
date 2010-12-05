package org.katasource.concoction {
/**
 * Base interface for defining any object which is {@link IConcoction}-aware.
 *
 * @author Bryan Turner
 * @since 0.1
 */
public interface IReagent {

    function get concoction():IConcoction;

    function set concoction(concoction:IConcoction):void;

    function get name():String;
}
}
