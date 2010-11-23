package org.katasource.concoction.support {


/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface IMediatorResolver {

    function resolveByType(mediatorClass:Class):*;

    function resolveByView(view:*):*;
}
}
