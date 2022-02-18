//
//  ObjectContext.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

/// Basic IOC container
///
/// Storage object definition information, automatically build dependencies between objects through
/// dependency injection, and manually resolve objects through dependency lookup
@objc(CBNObjectContext) open class ObjectContext: NSObject {
    
    /// ``Configuration`` classes collected according to strategy classes
    public var configurations: [Configuration.Type] = []
    
    let lock = DataLock()
    
    var objects = [ObjectKey: ObjectDefinition]()
    
    private let defaultScope: ObjectScope
    
    /// Designated initializer
    /// - Parameter defaultScope: The default life cycle of objects in the context
    @objc public init(defaultScope: ObjectScope = .default) {
        self.defaultScope = defaultScope
    }
    
    /// Clean all stored object definitions
    @objc public func clean() {
        lock.write { objects.removeAll() }
    }
    
    /// Release the objects within the specified life cycle
    /// - Parameter scope: Life cycle
    @objc public func release(byScope scope: ObjectScope) {
        lock.read()
        objects.values
            .filter { $0.scope == scope }
            .forEach { def in def.lock.write { def.storage.object = nil } }
        lock.unlock()
    }
    
    /// Release object by name
    /// - Parameter name: Name of object definition
    @objc public func release(byName name: String) {
        lock.read()
        objects.values
            .filter { $0.name == name }
            .forEach { def in def.lock.write { def.storage.object = nil } }
        lock.unlock()
    }
    
    /// Release all objects
    @objc public func releaseAll() {
        lock.read()
        objects.values
            .forEach { def in def.lock.write { def.storage.object = nil } }
        lock.unlock()
    }
    
    /// Register an object definition builder
    /// - Parameter builder: Object definition builder
    @objc public func register(builder: DefinitionBuilder) {
        let def = builder.definition
        if def.scope == nil {
            def.scope = defaultScope
        }
        
        func setKeys(withArgs: Bool) {
            var keys = [ObjectKey]()
            if let mianProtocol = def.protocol {
                // ObjC API dose not support factory args
                keys.append(ObjectKey(mianProtocol, def.name))
                for `protocol` in def.protocolAlias ?? [] {
                    keys.append(ObjectKey(`protocol`, def.name))
                }
            } else if let mianType = def.protocolType {
                let argsType = withArgs ? def.argsType : nil
                keys.append(ObjectKey(mianType, def.name, argsType))
                for type in def.protocolTypeAlias ?? [] {
                    keys.append(ObjectKey(type, def.name, argsType))
                }
            }
            
            lock.write { keys.forEach { objects[$0] = def } }
        }
        
        if def.constructor != nil || def.cls != nil {
            setKeys(withArgs: false)
        }
        if def.factory != nil {
            setKeys(withArgs: true)
        }
    }
    
    /// Batch registration of definitions in the ``Configuration`` protocol
    ///
    /// Register the definitions returned by the static method ``Configuration/definitions(of:)`` in the Configuration protocol.
    ///
    /// - Parameter configuration: Class conforming to the Configuration protocol
    public func register(configuration: Configuration.Type) {
        configurations.append(configuration)
        for definitionBuilder in configuration.definitions(of: self) {
            self.register(builder: definitionBuilder)
        }
    }
    
    /// Batch registration of ``Configuration``
    ///
    /// - Parameter configurations: Classes conforming to the Configuration protocol
    public func register(configurations: [Configuration.Type]) {
        for configuration in configurations {
            register(configuration: configuration)
        }
    }
    
}

extension ObjectContext {
    
    /// Resolve the class by Objective-C protocol
    ///
    /// Only used in Objective-C.
    ///
    /// * Example to register:
    /// ```
    /// DefinitionBuilder *builder = [[[KeyDefinitionBuilder new]
    ///                                protocol:@protocol(A)]
    ///                               cls:PetOwner.class];
    /// [context registerWithBuilder:builder];
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// [context objectClass:@protocol(A)];
    /// ```
    ///
    /// PetOwner implements protocol A defined by Objective-C.
    ///
    /// - Parameter protocol: Objective-C protocol
    /// - Returns: Resolved class
    @objc public func objectClass(_ `protocol`: Protocol) -> NSObject.Type? {
        lock.read { objects[ObjectKey(`protocol`)]?.cls }
    }
    
    /// Resolve the type by protocol
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(B.self)
    ///     .cls(PetOwner.self)
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// if let type = context.objectType(B.self) as? B.Type {
    ///     type.staticMethod()
    /// }
    /// ```
    ///
    /// PetOwner implements protocol B.
    ///
    /// - Parameter type: Type of object definition
    /// - Returns: Resolved type
    public func objectType<T>(_: T.Type) -> Any.Type? {
        lock.read { objects[ObjectKey(T.self)]?.type }
    }
    
    /// Resolve the object by Objective-C protocol
    ///
    /// Only used in Objective-C.
    ///
    /// * Example to register:
    /// ```
    /// DefinitionBuilder *builder = [[[KeyDefinitionBuilder new]
    ///                                protocol:@protocol(A)]
    ///                               cls:PetOwner.class];
    /// [context registerWithBuilder:builder];
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[@protocol(A)];
    /// ```
    ///
    /// PetOwner implements protocol A defined by Objective-C.
    ///
    /// - Parameter protocol: Objective-C protocol
    /// - Returns: Resolved object
    @objc public subscript(protocol: Protocol) -> NSObject? {
        get { ObjectResolver(self).resolve(ObjectKey(`protocol`)) {$0(self)} }
        set { subscriptSetter(ObjectKey(`protocol`), newValue) }
    }
    
    /// Resolve the object by Objective-C protocol and name
    ///
    /// Only used in Objective-C.
    ///
    /// * Example to register:
    /// ```
    /// KeyDefinitionBuilder *keyBuilder = [[KeyDefinitionBuilder alloc]
    ///                                     initWithName:"home"];
    /// DefinitionBuilder *builder = [[keyBuilder
    ///                                protocol:@protocol(BaseVC)]
    ///                               cls:HomeViewController.class];
    /// [context registerWithBuilder:builder];
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// [context objectWithProtocol:@protocol(BaseVC) name:"home"];
    /// ```
    ///
    /// - Parameters:
    ///     - protocol: Objective-C protocol
    ///     - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: Resolved object
    @objc public func object(protocol: Protocol, name: String) -> NSObject? {
        ObjectResolver(self).resolve(ObjectKey(`protocol`, name)) {$0(self)}
    }
    
    /// Resolve the object by type
    ///
    /// * Example to register:
    /// ```
    /// context.register(builder: Definition().cls(PetOwner.self))
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self]
    /// ```
    ///
    /// - Parameters:
    ///   - _: Type of object definition
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    ///   - Returns: Resolved object
    public subscript<T>(_: T.Type, name name: String? = nil) -> T? {
        get {
            let obj: T? = ObjectResolver(self).resolve(ObjectKey(T.self, name)) {$0(self)}
#if DEBUG
            if obj == nil {
                print(debugDescription)
            }
#endif
            return obj
        }
        set { subscriptSetter(ObjectKey(T.self, name), newValue) }
    }
    
    func resolve<T, A, FA>(
        _ name: String?,
        _: A.Type?,
        _ invoker: @escaping ((FA) -> Any) -> Any
    ) -> T? {
        let obj: T? = ObjectResolver(self).resolve(ObjectKey(T.self, name, A.self), invoker)
#if DEBUG
        if obj == nil {
            print(debugDescription)
        }
#endif
        return obj
    }
    
    private func subscriptSetter<T>(_ key: ObjectKey, _ newValue: T?) {
        if let newValue = newValue {
            register(builder: Definition().factory { _ in newValue })
        } else {
            lock.write { objects[key] = nil }
        }
    }
    
}

extension ObjectContext {
    open override var description: String {
        return "\(super.description.dropLast()); defaultScope: \(defaultScope)>"
    }
    
    open override var debugDescription: String {
        var des = "CarbonCore Debug:\nresolve failed, currently resolvable is:\n{\n\t"
        lock.read()
        objects
            .filter { $0.value.protocolType != nil }
            .sorted(by: { $0.0 < $1.0 })
            .forEach { key, value in
                var pre = ""
                var args = "", cls = "", type = ""
                if let v = value.argsType {
                    args = "\(v)"
                }
                if let v = value.cls {
                    cls = "\(v)"
                }
                if let v = value.protocolType {
                    type = "\(v)"
                }
                
                if value.constructor != nil || value.factory != nil {
                    if value.constructor != nil {
                        pre += "Constructor: "
                    } else {
                        pre += "Factory: "
                    }
                    if value.argsType == nil {
                        pre += "()"
                    } else {
                        pre += args
                    }
                    des += "\(pre) -> \(type)"
                } else if value.cls != nil {
                    des += "Class: \(cls): \(type)"
                } else {
                    
                }
                if let scope = value.scope {
                    des += ", scope: \(scope.name)\n\t"
                }
            }
        lock.unlock()
        _ = des.popLast()
        _ = des.popLast()
        des += "\n}"
        lock.unlock()
        return des
    }
}
