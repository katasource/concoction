package org.katasource.concoction.view.support {
import org.as3commons.lang.ClassUtils;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ReflectiveMediatorResolver extends MediatorResolverSupport implements IMediatorResolver {

    public function ReflectiveMediatorResolver() {
    }

    public function resolveByMediatedComponent(mediatedComponent:*):* {
        var mediatorClass:Class = getMediatorClassFromView(mediatedComponent);

        return ClassUtils.newInstance(mediatorClass, [mediatedComponent]);
    }

    public function resolveByType(mediatorClass:Class):* {
        return ClassUtils.newInstance(mediatorClass);
    }
}
}
