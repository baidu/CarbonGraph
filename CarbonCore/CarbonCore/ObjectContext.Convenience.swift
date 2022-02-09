//
//  ObjectContext.Convenience.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

extension ObjectContext {
    
    /// Create an object definition builder and register it
    /// - Parameters:
    ///   - protocol: Protocol implemented by the resolved object or the type of the resolved object
    ///   - cls: Class used to create the object or call the class method
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult public func register<T: NSObject>(
        protocol: Any.Type? = nil,
        cls: T.Type,
        name: String? = nil
    ) -> AutowiredDefinitionBuilder<T> {
        let keyBuilder = Definition(name)
        let factoryBuilder: FactoryDefinitionBuilder
        if let p = `protocol` {
            factoryBuilder = keyBuilder.protocol(p)
        } else {
            factoryBuilder = keyBuilder
        }
        let autowiredBuilder = factoryBuilder.cls(T.self)
        register(builder: autowiredBuilder)
        return autowiredBuilder
    }
    
    /// Create an object definition builder and register it
    /// - Parameters:
    ///   - protocol: Protocol implemented by the resolved object or the type of the resolved object
    ///   - object: Auto closure used to create the object
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult public func register<T>(
        protocol: Any.Type? = nil,
        object: @autoclosure @escaping () -> T,
        name: String? = nil
    ) -> AutowiredDefinitionBuilder<T> {
        let keyBuilder = Definition(name)
        let factoryBuilder: FactoryDefinitionBuilder
        if let p = `protocol` {
            factoryBuilder = keyBuilder.protocol(p)
        } else {
            factoryBuilder = keyBuilder
        }
        let autowiredBuilder = factoryBuilder.object(object())
        register(builder: autowiredBuilder)
        return autowiredBuilder
    }
    
    /// Create an object definition builder and register it
    ///
    /// Only used in Objective-C.
    /// 
    /// - Parameters:
    ///   - protocol: Protocol implemented by the resolved object
    ///   - cls: Class used to create the object or call the class method
    ///   - name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult @objc public func cbn_register(
        protocol: Protocol,
        cls: NSObject.Type,
        name: String
    ) -> DynamicAutowiredDefinitionBuilder {
        let builder = Definition(name).protocol(`protocol`).cls(cls)
        register(builder: builder)
        return builder
    }
    
    /// Create an object definition builder and register it
    ///
    /// Only used in Objective-C.
    ///
    /// - Parameters:
    ///   - protocol: Protocol implemented by the resolved object
    ///   - cls: Class used to create the object or call the class method
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult @objc public func cbn_register(
        protocol: Protocol, cls: NSObject.Type
    ) -> DynamicAutowiredDefinitionBuilder {
        let builder = Definition().protocol(`protocol`).cls(cls)
        register(builder: builder)
        return builder
    }
    
    /// Create an object definition builder and register it
    ///
    /// Only used in Objective-C.
    ///
    /// - Parameters:
    ///   - cls: Class used to create the object or call the class method
    ///   - name: Used as a unique identifier when resloving the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @discardableResult @objc public func cbn_register(
        cls: NSObject.Type, name: String
    ) -> DynamicAutowiredDefinitionBuilder {
        let builder = Definition(name)
            .protocol(NSObjectProtocol.self)
            .cls(cls)
        register(builder: builder)
        return builder
    }
    
}
