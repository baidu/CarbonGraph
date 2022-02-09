//
//  ObjectKey.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

class ObjectKey {
    
    convenience init(_ protocol: Protocol,
                     _ name: String? = nil) {
        var identifier = NSStringFromProtocol(`protocol`)
        if let name = name {
            identifier.append("; \(name)")
        }
        self.init(identifier: identifier)
    }
    
    convenience init(_ protocolType: Any.Type,
                     _ name: String? = nil,
                     _ argsType: Any.Type? = nil) {
        var identifier = "\(String(reflecting: protocolType))"
        let objcPrefix = "__C."
        if identifier.hasPrefix(objcPrefix) {
            identifier = String(identifier.dropFirst(objcPrefix.count))
        }
        if let argsType = argsType {
            identifier.append("; \(String(reflecting: argsType))")
        }
        if let name = name {
            identifier.append("; \(name)")
        }
        self.init(identifier: identifier)
    }
    
    fileprivate let identifier: String
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
}

extension ObjectKey: Hashable, Comparable {
    
    static func == (lhs: ObjectKey, rhs: ObjectKey) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    static func < (lhs: ObjectKey, rhs: ObjectKey) -> Bool {
        lhs.identifier < rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
}

extension ObjectKey: CustomStringConvertible {
    var description: String { identifier }
}
