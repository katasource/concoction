package org.katasource.concoction.support {
import org.as3commons.lang.ClassUtils;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ReflectiveMediatorResolver extends MediatorResolverSupport implements IMediatorResolver {

    public function ReflectiveMediatorResolver() {
    }

    public function resolveByType(mediatorClass:Class):* {
        return ClassUtils.newInstance(mediatorClass);
    }

    public function resolveByView(view:*):* {
        var mediatorClass:Class = getMediatorClassFromView(view);

        return ClassUtils.newInstance(mediatorClass, [view]);
    }
}
}
