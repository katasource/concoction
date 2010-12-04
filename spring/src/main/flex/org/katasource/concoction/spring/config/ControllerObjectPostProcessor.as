package org.katasource.concoction.spring.config {
import org.as3commons.lang.ClassUtils;
import org.as3commons.lang.StringUtils;
import org.as3commons.logging.ILogger;
import org.as3commons.logging.LoggerFactory;
import org.as3commons.reflect.MetaData;
import org.as3commons.reflect.MetaDataContainer;
import org.as3commons.reflect.Method;
import org.as3commons.reflect.Type;
import org.katasource.concoction.controller.IControllerManager;
import org.springextensions.actionscript.ioc.factory.config.IObjectPostProcessor;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class ControllerObjectPostProcessor implements IObjectPostProcessor {

    private var _logger:ILogger = LoggerFactory.getClassLogger(ControllerObjectPostProcessor);
    private var _manager:IControllerManager;

    public function ControllerObjectPostProcessor(manager:IControllerManager) {
        _manager = manager;
    }

    public function postProcessAfterInitialization(object:*, objectName:String):* {
        return object;
    }

    public function postProcessBeforeInitialization(object:*, objectName:String):* {
        var type:Type = Type.forInstance(object);

        var controller:MetaData = getFirstMetaData(type, objectName, "Controller");
        if (controller == null) {
            //If the [Controller] metadata attribute is not specified, this object does not contribute to the
            //controller manager and needs no further processing.
            return object;
        }

        //The [Controller] metadata attribute has one optional parameter which can be used to define the fully-
        //qualified name of a class containing constant values used as notification names. This allows strong,
        //reliable notification behaviors by ensuring notification names are always typed correctly. Applying a
        //constant class name to the [Controller] sets the default class which is used if a [NotificationMapping]
        //metadata attribute has a field property but no class.
        var defaultNameClass:Class = null;
        if (controller.hasArgumentWithKey("nameClass")) {
            defaultNameClass = ClassUtils.forName(controller.getArgument("nameClass").value);
        }

        //Now we iterate over the methods on the controller object and setup notification callbacks for any which
        //have the [NotificationMapping] metadata attribute.
        for each (var method:Method in type.methods) {
            var objectAndMethod:String = objectName + "." + method.name;
            var notificationMapping:MetaData = getFirstMetaData(method, objectAndMethod, "NotificationMapping");
            if (notificationMapping == null) {
                continue;
            }

            //Now the fun part. We have a [NotificationMapping], so the next step is to calculate what notification
            //we are mapping the method to. This can happen in 3 different ways:
            //1. The mapping defines no additional arguments. The method name itself is parsed to compute the name of
            //   the notification. This is the most frail technique and should be used with appropriate caution!
            //2. The mapping defines only a "nameField" argument. The default name class is assumed to contain a static
            //   constant field with the specified name.
            //3. The mapping defines both a "nameClass" and a "nameField" argument. The specified class is assumed to
            //   contain a constant field with the specified name and the default name class is ignored.
            var notificationName:String = null;

            var metadataArguments:Array = notificationMapping.arguments;
            if (metadataArguments.length == 0) {
                notificationName = method.name;
            } else if (notificationMapping.hasArgumentWithKey("nameField")) {
                var nameField:String = notificationMapping.getArgument("nameField").value;
                if (metadataArguments.length == 1) {
                    notificationName = defaultNameClass[nameField];
                } else if (metadataArguments.length == 2 && notificationMapping.hasArgumentWithKey("nameClass")) {
                    var nameClass:Class = ClassUtils.forName(notificationMapping.getArgument("nameClass").value);

                    notificationName = nameClass[nameField];
                }
            }

            if (StringUtils.isEmpty(notificationName)) {
                _logger.error("The NotificationMapping for [{0}] is invalid. No notification name could be " +
                        "calculated for the mapping. Are your constants correct?", [objectAndMethod]);
            } else {
                _logger.debug("Registering notification callback: [{0}]->[{1}]", [notificationName, objectAndMethod]);
                //TODO: Flesh out IControllerManager interface
            }
        }
        return object;
    }

    protected function getFirstMetaData(container:MetaDataContainer, objectName:String, metaDataName:String):MetaData {
        if (container.hasMetaData(metaDataName)) {
            //Technically this should only ever have one entry; annotating the same class with more than one instance of
            //the same metadata attribute doesn't really make much sense. If there are multiple, we log a warning and
            //only process the first.
            var metadata:Array = container.getMetaData(metaDataName);

            var first:MetaData = metadata[0];
            if (metadata.length > 1) {
                _logger.warn("[{0}] has {1} {2} metadata attributes applied. Only the first of these will be processed",
                        [objectName, metadata.length, metaDataName]);
            }
            return first;
        }
        return null;
    }
}
}
