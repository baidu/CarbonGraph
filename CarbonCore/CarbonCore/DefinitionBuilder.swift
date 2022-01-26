//
//  DefinitionBuilder.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

public typealias Definition = KeyDefinitionBuilder
public typealias Definitions = [DefinitionBuilder]

/// DefinitionBuilder is a DSL Syntax used to build ObjectDefinition
///
/// ObjectDefinition is the definition of the object and stores the data needed to resolve the object.
///
/// These data are divided into 4 types:
/// * Key: The unique identifier of the object definition, used to locate
/// * Factory: The closure used to create the object and the dependencies that need to be built during creation
/// * Autowired: Dependencies that need to be built after creation
/// * Configuration: Other configuration of the object
///
/// DefinitionBuilder has 10 subclasses. Each subclass is used to set a type of ObjectDefinition data.
///
/// Their corresponding relationship is as follows:
/// * Key: ``KeyDefinitionBuilder``, ``AliasDefinitionBuilder``,
/// ``DynamicAliasDefinitionBuilder``
/// * Factory: ``FactoryDefinitionBuilder``, ``DynamicFactoryDefinitionBuilder``,
/// ``DynamicClassDefinitionBuilder``
/// * Autowired: ``AutowiredDefinitionBuilder``, ``DynamicAutowiredDefinitionBuilder``
/// * Configuration: ``AttributeDefinitionBuilder``, ``ActionDefinitionBuilder``
///
/// The method of each DefinitionBuilder controls which methods can be used in the next step by controlling
/// the returned DefinitionBuilder type. So you can only complete an ObjectDefinition in a set order.
/// Each DefinitionBuilder controls which settings can be omitted by controlling the inheritance relationship.
///
/// The specifications are as follows, '>' means order, italics means it can be omitted. It doesn't matter
/// if you are confused, the compiler will tell you the correct way.
///
/// * *Key* > *Alias* > Factory > *Autowired* > *Attribute* > *Action*
/// * Key > *DynamicAlias* > *DynamicFactory* > DynamicClass  > *DynamicAutowired* > *Attribute* > *Action*
public class DefinitionBuilder: NSObject {
    
    let definition: ObjectDefinition
    
    init(_ definition: ObjectDefinition) {
        self.definition = definition
    }
    
    init(_ definitionBuilder: DefinitionBuilder) {
        self.definition = definitionBuilder.definition
    }
    
}

extension DefinitionBuilder {
    public override var description: String {
        return "\(super.description.dropLast()); definition: \(definition)"
    }
}

/// KeyDefinitionBuilder is always used as the head of the DSL, regardless of whether its value is omitted
///
/// In order to keep the syntax concise and hide the complexity of various types of DefinitionBuilder,
/// please do not use KeyDefinitionBuilder directly, but use its alias ``Definition`` as the beginning.
///
/// See ``DefinitionBuilder``or other subclasses for more syntax.
public class KeyDefinitionBuilder: FactoryDefinitionBuilder {
    
    /// Create a KeyDefinitionBuilder without setting any value, just as the beginning of the syntax
    @objc public convenience init() {
        self.init(nil)
    }
    
    /// Create a KeyDefinitionBuilder and set the name at the same time
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition("home")
    ///     .protocol(UIViewController.self)
    ///     .object(HomeViewController())
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[UIViewController.self, name: "home"]
    /// ```
    ///
    /// - Parameter name: Name of object definition, If there are multiple definitions of the same type,
    ///   you need to specify the name
    @objc(initWithName:) public init(_ name: String?) {
        let objectDefinition = ObjectDefinition()
        objectDefinition.name = name
        super.init(objectDefinition)
    }
    
    /// Set the protocol implemented by the resolved object
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
    /// - Parameter protocol: Protocol implemented by the resolved object
    /// - Returns: DefinitionBuilder that can set alias protocol of definition
    @objc public func `protocol`(
        _ protocol: Protocol
    ) -> DynamicAliasDefinitionBuilder {
        self.definition.protocol = `protocol`
        return DynamicAliasDefinitionBuilder(self.definition)
    }
    
    /// Set the protocol implemented by the resolved object or the type of the resolved object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(B.self)
    ///     .object(PetOwner())
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[B.self]
    /// ```
    ///
    /// PetOwner implements protocol B.
    ///
    /// - Parameter protocolType: Protocol implemented by the resolved object or the type of the resolved object
    /// - Returns: DefinitionBuilder that can set alias protocol (or type) of definition
    public func `protocol`(_ protocolType: Any.Type) -> AliasDefinitionBuilder {
        self.definition.protocolType = protocolType
        return AliasDefinitionBuilder(self.definition)
    }
    
}

/// AliasDefinitionBuilder is used after KeyDefinitionBuilder to set the alias protocol (or type) of definition
///
/// See ``DefinitionBuilder``or other subclasses for more syntax.
public class AliasDefinitionBuilder: FactoryDefinitionBuilder {
    
    /// Set the alias protocol implemented by the resolved object or the alias type of the resolved object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(Person.self)
    ///     .alias(A.self)
    ///     .object(PetOwner())
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[Person.self]
    /// context[Animal.self]
    /// ```
    ///
    /// PetOwner inherited from Person and implements A protocol.
    ///
    /// - Parameter protocolType: Protocol implemented by the resolved object or the type of
    /// the resolved object
    /// - Returns: DefinitionBuilder that can set alias protocol (or type) of definition
    public func alias(_ protocolType: Any.Type) -> AliasDefinitionBuilder {
        if self.definition.protocolAlias == nil {
            self.definition.protocolTypeAlias = [protocolType]
        } else {
            self.definition.protocolTypeAlias?.append(protocolType)
        }
        return self
    }
    
    /// Set the alias protocols implemented by the resolved object or the alias types of the resolved object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(Person.self)
    ///     .alias([A.self, B.self])
    ///     .object(PetOwner())
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[Person.self]
    /// context[A.self]
    /// context[B.self]
    /// ```
    ///
    /// PetOwner inherited from Person and implements both A and B protocols.
    ///
    /// - Parameter alias: Protocols implemented by the resolved object or the types of the
    /// resolved object
    /// - Returns: DefinitionBuilder that can set the closure or class used to create the object and the
    /// dependencies that need to be built during creation
    public func alias(_ alias: [Any.Type]) -> FactoryDefinitionBuilder {
        self.definition.protocolTypeAlias = alias
        return FactoryDefinitionBuilder(self.definition)
    }
    
}

/// DynamicAliasDefinitionBuilder is used after KeyDefinitionBuilder to set the alias protocol of
/// definition
///
/// Only used in Objective-C.
///
/// See ``DefinitionBuilder``or other subclasses for more syntax.
public class DynamicAliasDefinitionBuilder: DynamicFactoryDefinitionBuilder {
    
    /// Set the alias protocol implemented by the resolved object
    ///
    /// Only used in Objective-C.
    ///
    /// * Example to register:
    /// ```
    /// DefinitionBuilder *builder = [[[[KeyDefinitionBuilder new]
    ///                                 protocol:@protocol(A)]
    ///                                aliasProtocol:@protocol(B)]
    ///                               cls:PetOwner.class];
    /// [context registerWithBuilder:builder];
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[@protocol(A)];
    /// context[@protocol(B)];
    /// ```
    ///
    /// PetOwner implements both A and B protocols.
    ///
    /// - Parameter protocol: Protocol implemented by the resolved object
    /// - Returns: DefinitionBuilder that can set alias protocol of definition
    @objc public func aliasProtocol(_ protocol: Protocol) -> DynamicAliasDefinitionBuilder {
        if self.definition.protocolAlias == nil {
            self.definition.protocolAlias = [`protocol`]
        } else {
            self.definition.protocolAlias?.append(`protocol`)
        }
        return self
    }
    
    /// Set the alias protocols implemented by the resolved object
    ///
    /// Only used in Objective-C.
    ///
    /// * Example to register:
    /// ```
    /// DefinitionBuilder *builder = [[[[KeyDefinitionBuilder new]
    ///                                 protocol:@protocol(A)]
    ///                                alias:@[@protocol(B), @protocol(C)]]
    ///                               cls:PetOwner.class];
    /// [context registerWithBuilder:builder];
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[@protocol(A)];
    /// context[@protocol(B)];
    /// context[@protocol(C)];
    /// ```
    ///
    /// PetOwner implements three protocols A, B, and C.
    ///
    /// - Parameter alias: Protocols implemented by the resolved object
    /// - Returns: DefinitionBuilder that can set the closure or class used to create the object
    @objc public func alias(_ alias: [Protocol]) -> DynamicFactoryDefinitionBuilder {
        self.definition.protocolAlias = alias
        return DynamicFactoryDefinitionBuilder(self.definition)
    }
}

/// FactoryDefinitionBuilder is used after DefinitionBuilder of key type to set the closure or class used to
/// create the object and the dependencies that need to be built during creation
///
/// See ``DefinitionBuilder``or other subclasses for more syntax.
public class FactoryDefinitionBuilder: DefinitionBuilder {
    
    /// Set the constructor (without parameter) of the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition().constructor(PetOwner.init)
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[PetOwner.self]
    /// ```
    ///
    /// - Parameter constructor: Constructor (without parameter) of the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func constructor<T>(
        _ constructor: @escaping () -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeConstructor { _ in constructor() }
        return AutowiredDefinitionBuilder(self.definition)
    }
    
    /// Set the factory (without parameter) used to create the object
    ///
    /// When using a factory to create object, you can manually inject dependent objects through
    /// constructor, properties, methods, etc.
    /// When using the constructor with parameters or autowired to automatically inject objects that can't
    /// meet the requirements, you can use the factory to control the resolving process more flexibly.
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MainVC.self)
    ///     .factory { context in
    ///         let tabVC = UITabBarController()
    ///         tabVC.viewControllers = [
    ///             context[HomeVC.self],
    ///             context[FileVC.self],
    ///             context[MeVC.self]
    ///         ]
    ///         return tabVC
    ///     }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MainVC.self]
    /// ```
    ///
    /// - Parameter f: Factory (without parameter) used to create the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func factory<T>(
        _ f: @escaping (ObjectContext) -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeFactory(f)
    }
    
    /// Set the auto closure used to create the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition().object(HomeViewController() as HomeVC)
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[HomeVC.self]
    /// ```
    ///
    /// - Parameter obj: Auto closure used to create the object
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func object<T>(
        _ obj: @autoclosure @escaping () -> T
    ) -> AutowiredDefinitionBuilder<T> {
        storeType(T.self).storeFactory { (_: ObjectContext) in obj() }
    }
    
    /// Set the class used to create the object or call the class method
    ///
    /// The framework will call the init method without parameter to create the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(FileVC.self)
    ///     .cls(FileViewController.self)
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[FileVC.self]
    /// ```
    ///
    /// - Parameter cls: Class used to create the object or call the class method
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func cls<T: NSObject>(
        _ cls: T.Type
    ) -> AutowiredDefinitionBuilder<T> {
        return AutowiredDefinitionBuilder(storeType(cls))
    }
    
    func storeArgs<Args>(_: Args.Type) -> FactoryDefinitionBuilder {
        if self.definition.argsType == nil {
            self.definition.argsType = Args.self
        }
        return self
    }
    
    func storeFactory<T, Args>(
        _ factory: @escaping (Args) -> Any
    ) -> AutowiredDefinitionBuilder<T> {
        self.definition.factory = factory
        return AutowiredDefinitionBuilder(self.definition)
    }
    
    func storeConstructor(_ constructor: @escaping (ObjectContext) -> Any?) {
        self.definition.constructor = constructor
    }
    
    func storeType<T>(_: T.Type) -> Self {
        assert(T.self != Void.self, "The return value of the constructor or factory can not be 'Void' !")
        if self.definition.protocolType == nil &&
            self.definition.protocol == nil {
            self.definition.protocolType = T.self
        }
        self.definition.type = T.self
        return self
    }
}

/// DynamicFactoryDefinitionBuilder is used after DefinitionBuilder of key type to set the closure used to
/// create the object
///
/// Only used in Objective-C.
///
/// See ``DefinitionBuilder``or other subclasses for more syntax.
public class DynamicFactoryDefinitionBuilder: DynamicClassDefinitionBuilder {
    
    /// Set the factory (without parameter) used to create the object
    ///
    /// Only used in Objective-C.
    ///
    /// When using a factory to create object, you can manually inject dependent objects through
    /// constructor, properties, methods, etc.
    /// When using the autowired to automatically inject objects that can't meet the requirements, you can
    /// use the factory to control the resolving process more flexibly.
    ///
    /// Only used in Objective-C. Because OC does not support generics, the type of the object created by
    /// the factory can't be obtained (The class method can't be used), so after using this method,
    /// the `cls(_:)` method must be used to set the class. When resolving the object, if there is a
    /// factory, it will be used first.
    ///
    /// * Example to register:
    /// ```
    /// DefinitionBuilder *builder = [[[KeyDefinitionBuilder new]
    ///                                protocol:@protocol(MainVC)]
    ///                               factory:^NSObject * _Nonnull(ObjectContext * _Nonnull context) {
    ///     UITabBarController *tabVC = [[UITabBarController alloc] init];
    ///     tabVC.viewControllers = @[
    ///         context[@protocol(HomeVC)],
    ///         context[@protocol(FileVC)],
    ///         context[@protocol(MeVC)]
    ///     ];
    ///     return tabVC;
    /// }];
    /// [context registerWithBuilder:builder];
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[@protocol(MainVC)];
    /// ```
    ///
    /// - Parameter f: Factory (without parameter) used to create the object
    /// - Returns: DefinitionBuilder that can set class used to call the class method
    @objc public func factory(
        _ f: @escaping (ObjectContext) -> NSObject
    ) -> DynamicClassDefinitionBuilder {
        storeFactory(f)
    }
    
    private func storeFactory<Args>(
        _ factory: @escaping (Args) -> Any
    ) -> DynamicClassDefinitionBuilder {
        self.definition.factory = factory
        return DynamicClassDefinitionBuilder(self.definition)
    }
    
}

/// DynamicClassDefinitionBuilder is used after DefinitionBuilder of key type or
/// DynamicFactoryDefinitionBuilder to set the class used to create the object or call the class method
///
/// Only used in Objective-C.
///
/// See ``DefinitionBuilder``or other subclasses for more syntax.
public class DynamicClassDefinitionBuilder: DefinitionBuilder {
    
    
    /// Set the class used to create the object or call the class method
    ///
    /// Only used in Objective-C.
    ///
    /// The framework will call the init method without parameter to create the object
    ///
    /// * Example to register:
    /// ```
    /// DefinitionBuilder *builder = [[[KeyDefinitionBuilder new]
    ///                                protocol:@protocol(MeVC)]
    ///                               cls:MeViewController.class];
    /// [context registerWithBuilder:builder];
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[@protocol(MeVC)];
    /// ```
    ///
    /// - Parameter cls: Class used to create the object or call the class method
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @objc public func cls(_ cls: NSObject.Type) -> DynamicAutowiredDefinitionBuilder {
        if self.definition.protocolType == nil &&
            self.definition.protocol == nil {
            self.definition.protocolType = cls
        }
        self.definition.cls = cls
        return DynamicAutowiredDefinitionBuilder(self.definition)
    }
    
}

/// AutowiredDefinitionBuilder is used after DefinitionBuilder of factory type to set the dependencies that
/// need to be built after creation
///
/// See ``DefinitionBuilder``or other subclasses for more syntax.
public class AutowiredDefinitionBuilder<T>: DynamicAutowiredDefinitionBuilder {
    
    /// Set the optional property KeyPath of the object to make the framework to automatically
    /// inject dependency
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MeVC.self)
    ///     .cls(MeViewController.self)
    ///     .property(\.configModel)
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MeVC.self]
    /// ```
    ///
    /// - Parameter keyPath: Optional property KeyPath of the object to make the framework to
    /// automatically inject dependency
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func property<V>(
        _ keyPath: ReferenceWritableKeyPath<T, Optional<V>>
    ) -> AutowiredDefinitionBuilder<T> {
        return storeProperty {
            guard let obj = $1 as? T else { return }
            guard let value = $0[V.self] else { return }
            obj[keyPath: keyPath] = value
        }
    }
    
    /// Set the non-optional property KeyPath of the object to make the framework to automatically
    /// inject dependency
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(MeVC.self)
    ///     .cls(MeViewController.self)
    ///     .property(\.userModel)
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[MeVC.self]
    /// ```
    ///
    /// - Parameter keyPath: Non-optional property KeyPath of the object to make the framework to
    /// automatically inject dependency
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    public func property<V>(
        _ keyPath: ReferenceWritableKeyPath<T, V>
    ) -> AutowiredDefinitionBuilder<T> {
        return storeProperty {
            guard let obj = $1 as? T else { return }
            guard let value = $0[V.self] else { return }
            obj[keyPath: keyPath] = value
        }
    }
    
    func storeProperty(
        _ propertySetter: @escaping (ObjectContext, Any) -> Void
    ) -> AutowiredDefinitionBuilder<T> {
        if self.definition.properties == nil {
            self.definition.properties = [propertySetter]
        } else {
            self.definition.properties?.append(propertySetter)
        }
        return self
    }
    
    func storeSetter(
        _ setter: @escaping (ObjectContext, Any) -> Void
    ) -> AutowiredDefinitionBuilder<T> {
        if self.definition.setters == nil {
            self.definition.setters = [setter]
        } else {
            self.definition.setters?.append(setter)
        }
        return self
    }
    
}

/// DynamicAutowiredDefinitionBuilder is used after DefinitionBuilder of factory type to set the dependencies
/// that need to be built after creation
///
/// Only used in Objective-C.
///
/// See ``DefinitionBuilder``or other subclasses for more syntax.
public class DynamicAutowiredDefinitionBuilder: AttributeDefinitionBuilder {
    
    /// Set the property name of the object to make the framework to automatically inject dependency
    ///
    /// Only used in Objective-C.
    ///
    /// * Example to register:
    /// ```
    /// DefinitionBuilder *builder = [[[[KeyDefinitionBuilder new]
    ///                                 protocol:@protocol(MeVC)]
    ///                                cls:MeViewController.class]
    ///                               propertyName:@"userModel"];
    /// [context registerWithBuilder:builder];
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[@protocol(MeVC)]
    /// ```
    ///
    /// - Parameter propertyName: Property name of the object to make the framework to
    /// automatically inject dependency
    /// - Returns: DefinitionBuilder that can set the dependencies that need to be built after creation
    @objc public func propertyName(
        _ propertyName: String
    ) -> DynamicAutowiredDefinitionBuilder {
        if self.definition.propertiesName == nil {
            self.definition.propertiesName = [propertyName]
        } else {
            self.definition.propertiesName?.append(propertyName)
        }
        return self
    }
    
    /// Set the properties name of the object to make the framework to automatically inject dependencies
    ///
    /// Only used in Objective-C.
    ///
    /// * Example to register:
    /// ```
    /// DefinitionBuilder *builder = [[[[KeyDefinitionBuilder new]
    ///                                 protocol:@protocol(MeVC)]
    ///                                cls:MeViewController.class]
    ///                               propertiesName:@[@"userModel", @"configModel"]];
    /// [context registerWithBuilder:builder];
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[@protocol(MeVC)]
    /// ```
    ///
    /// - Parameter propertiesName: Properties name of the object to make the framework to
    /// automatically inject dependencies
    /// - Returns: DefinitionBuilder that can set the attributes of the object
    @objc public func propertiesName(
        _ propertiesName: [String]
    ) -> AttributeDefinitionBuilder {
        self.definition.propertiesName = propertiesName
        return AttributeDefinitionBuilder(self.definition)
    }
    
}

/// AttributeDefinitionBuilder is used after DefinitionBuilder of autowired or factory type to set the attributes
/// of the object
///
/// See ``DefinitionBuilder``or other subclasses for more syntax.
public class AttributeDefinitionBuilder: ActionDefinitionBuilder {
    
    /// Set the scope (life cycle) of the object
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(HomeVC.self)
    ///     .cls(HomeViewController.self)
    ///     .scope(.singleton)
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[HomeVC.self]
    /// ```
    ///
    /// - Parameter scope: Scope (life cycle) of the object
    /// - Returns: DefinitionBuilder that can set the callback action of the object creation process
    @discardableResult
    @objc public func scope(_ scope: ObjectScope) -> ActionDefinitionBuilder {
        self.definition.scope = scope
        return ActionDefinitionBuilder(self.definition)
    }
}

/// ActionDefinitionBuilder is used after DefinitionBuilder of attribute, autowired or factory type to set the
/// callback action of the object creation process
///
/// See ``DefinitionBuilder``or other subclasses for more syntax.
public class ActionDefinitionBuilder: DefinitionBuilder {
    
    /// Set the callback action for the completion of object resolving
    ///
    /// * Example to register:
    /// ```
    /// let builder = Definition()
    ///     .protocol(HomeVC.self)
    ///     .cls(HomeViewController.self)
    ///     .completed { _, _ in
    ///         Logger.pageView("home")
    ///     }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[HomeVC.self]
    /// ```
    ///
    /// - Parameter completed: Callback action for the completion of object resolving
    /// - Returns: DefinitionBuilder that can set the callback action of the object creation process
    @discardableResult
    @objc public func completed(_ completed: @escaping (ObjectContext, Any) -> Void) -> ActionDefinitionBuilder {
        if self.definition.actions == nil {
            self.definition.actions = [completed]
        } else {
            self.definition.actions?.append(completed)
        }
        return self
    }
}
