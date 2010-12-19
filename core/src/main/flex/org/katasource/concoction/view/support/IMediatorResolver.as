package org.katasource.concoction.view.support {


/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface IMediatorResolver {

    function resolveByMediatedComponent(mediatedComponent:*):*;

    function resolveByType(mediatorClass:Class):*;
}
}
