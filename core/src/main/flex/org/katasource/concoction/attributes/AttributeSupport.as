package org.katasource.concoction.attributes {
import org.as3commons.logging.ILogger;
import org.as3commons.logging.LoggerFactory;
import org.as3commons.reflect.MetaData;
import org.as3commons.reflect.MetaDataContainer;

/**
 * @author Bryan Turner
 * @since 0.1
 */
public class AttributeSupport {

    public function AttributeSupport() {
    }

    protected static function getFirstMetaData(container:MetaDataContainer, metaDataName:String):MetaData {
        var metadata:Array = container.getMetaData(metaDataName);
        if (metadata == null || metadata.length == 0) {
            return null;
        }

        //Technically this should only ever have one entry; annotating the same class with more than one instance of
        //the same metadata attribute doesn't really make much sense. If there are multiple, we log a warning and
        //only process the first.
        var first:MetaData = metadata[0];
        if (metadata.length > 1) {
            var logger:ILogger = LoggerFactory.getClassLogger(AttributeSupport);
            logger.warn("[{0}] has {2} {3} metadata attributes applied. Only the first of these will be processed",
                    [container["name"], metadata.length, metaDataName]);
        }
        return first;
    }
}
}
