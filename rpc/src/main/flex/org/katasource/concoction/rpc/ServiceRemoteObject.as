package org.katasource.concoction.rpc {
import mx.core.mx_internal;
import mx.rpc.AbstractOperation;
import mx.rpc.remoting.RemoteObject;

import org.katasource.concoction.IConcoction;

use namespace mx_internal;

public class ServiceRemoteObject extends RemoteObject implements IService {

    private var _concoction:IConcoction;

    public function ServiceRemoteObject(destinationName:String) {
        super(destinationName);
    }

    public function get concoction():IConcoction {
        return _concoction;
    }

    public function set concoction(value:IConcoction):void {
        _concoction = value;

        for (var operation:String in operations) {
            var o:* = operations[operation];
            if (o is ServiceOperation) {
                ServiceOperation(o).concoction = value;
            }
        }
    }

    public function get name():String {
        return destination;
    }

    public override function getOperation(name:String):AbstractOperation {
        var operation:AbstractOperation = findOperation(name);
        if (operation == null) {
            operation = new ServiceOperation(this, name, concoction);
            operation.asyncRequest = asyncRequest;

            operations[name] = operation;
        }
        return operation;
    }

    private function findOperation(name:String):AbstractOperation {
        var operation:Object = operations[name];

        return (operation is AbstractOperation ? operation as AbstractOperation : null);
    }
}
}