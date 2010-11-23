package org.katasource.concoction.support {
import org.as3commons.lang.ClassUtils;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class MediatorResolverSupport {

    public function MediatorResolverSupport() {
    }

    protected function getMediatorClassFromView(view:*):Class {
        var viewClass:Class = ClassUtils.forInstance(view);

        return getMediatorClassFromViewClass(viewClass);
    }

    protected function getMediatorClassFromViewClass(viewClass:Class):Class {
        var mediatorClassName:String = ClassUtils.getFullyQualifiedName(viewClass) + "Mediator";

        return ClassUtils.forName(mediatorClassName);
    }
}
}
