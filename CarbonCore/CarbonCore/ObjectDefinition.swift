//
//  ObjectDefinition.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

class ObjectDefinition {
    
    let lock = DataLock()
    
    var name: String?
    var `protocol`: Protocol?
    var protocolType: Any.Type?
    
    var protocolAlias: [Protocol]?
    var protocolTypeAlias: [Any.Type]?
    var cls: NSObject.Type? {
        get { type as? NSObject.Type }
        set { type = newValue }
    }
    var constructor: ((ObjectContext) -> Any?)?
    
    var type: Any.Type?
    var argsType: Any.Type?
    var factory: Any?
    var propertiesName: [String]?
    var properties: [(ObjectContext, AnyObject) -> Void]?
    var setters: [(ObjectContext, Any) -> Void]?
    
    var scope: ObjectScope?
    
    lazy var storage: ObjectStorage = { [unowned self] in
        (self.scope ?? .default).makeStorage()
    }()
    
    var actions: [(ObjectContext, Any) -> Void]?
    
}

extension ObjectDefinition: CustomStringConvertible {
    var description: String {
        var des = ""
        if let pt = protocolType {
            des += "protocolType: \(pt), "
        }
        if let cls = cls {
            des += "cls: \(cls), "
        }
        if let cons = constructor {
            des += "constructor: \(String(describing: cons)), "
        }
        if let fac = factory {
            des += "factory: \(fac), "
        }
        if let argsT = argsType {
            des += "argsType: \(argsT), "
        }
        if let name = name {
            des += "name: \(name), "
        }
        if let scope = scope {
            des += "scope: \(scope)"
        }
        return des
    }
}
