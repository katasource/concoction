package org.katasource.concoction.spring.view {
import org.katasource.concoction.view.IMediator;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public interface IDelegatingMediator extends IMediator {

    function get delegate():*;
}
}
