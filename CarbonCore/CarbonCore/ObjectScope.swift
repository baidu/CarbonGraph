//
//  ObjectScope.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

/// Object life cycle
@objc(CBNObjectScope) public class ObjectScope: NSObject {
    let storageConstructor: () -> ObjectStorage
    
    func makeStorage() -> ObjectStorage {
        storageConstructor()
    }
    
    /// Name of scope
    @objc public let name: String
    
    init(storageConstructor: @escaping () -> ObjectStorage, name: String) {
        self.storageConstructor = storageConstructor
        self.name = name
    }
    
}

extension ObjectScope {
    
    /// Default object life cycle, alias of prototype
    @objc(default_) public static let `default` = prototype
    
    /// Local object life cycle
    @objc public static let prototype = ObjectScope(
        storageConstructor: AutoreleaseStorage.init, name: "prototype"
    )
    
    /// Singleton object life cycle
    @objc public static let singleton = ObjectScope(
        storageConstructor: StrongStorage.init, name: "singleton"
    )
    
    /// Weak reference singleton object life cycle
    @objc public static let singletonWeak = ObjectScope(
        storageConstructor: WeakStorage.init, name: "singletonWeak"
    )
}

extension ObjectScope {
    public override var description: String {
        return "\(super.description.dropLast()); name: \(name)>"
    }
}
