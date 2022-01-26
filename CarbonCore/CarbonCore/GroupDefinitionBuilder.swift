//
//  GroupDefinitionBuilder.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

public typealias GroupDefinitions = GroupDefinitionBuilder

/// GroupDefinitionBuilder is used to group other DefinitionBuilders for unified configuration
///
/// In order to keep the syntax concise and hide the complexity of various types of DefinitionBuilder, please
/// do not use GroupDefinitionBuilder directly, but use its alias ``GroupDefinitions`` as the beginning.
///
/// See ``DefinitionBuilder``or other subclasses for more syntax.
public class GroupDefinitionBuilder {
    
    var builders: [DefinitionBuilder]
    
    /// Create a GroupDefinitionBuilder and pass the other DefinitionBuilders to be grouped
    ///
    /// * Example to register:
    /// ```
    /// let builder = GroupDefinitions {
    ///     Definition("home").object(HomeViewController())
    ///     Definition("file").object(FileViewController())
    ///     Definition("me").object(MeViewController())
    /// }
    /// .alias(UIViewController.self)
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[UIViewController.self, name: "home"]
    /// context[UIViewController.self, name: "file"]
    /// context[UIViewController.self, name: "me"]
    /// ```
    ///
    /// - Parameter builders: Other DefinitionBuilders to be grouped
    public init(@ConfigurationBuilder builders: () -> Definitions) {
        self.builders = builders()
    }
    
    /// Set the name of all the DefinitionBuilders in the group
    ///
    /// * Example to register:
    /// ```
    /// let builder = GroupDefinitions {
    ///     Definition().protocol(HomeVC.self).object(HomeViewController())
    ///     Definition().protocol(FileVC.self).object(FileViewController())
    ///     Definition().protocol(MeVC.self).object(MeViewController())
    /// }
    /// .name("root")
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[HomeVC.self, name: "root"]
    /// context[FileVC.self, name: "root"]
    /// context[MeVC.self, name: "root"]
    /// ```
    ///
    /// - Parameter name: Name of object definition
    /// - Returns: DefinitionBuilder that can group other DefinitionBuilders
    public func name(_ name: String) -> Self {
        builders.forEach { builder in
            if builder.definition.name == nil {
                builder.definition.name = name
            }
        }
        return self
    }
    
    /// Set the alias protocol of all the DefinitionBuilders in the group
    ///
    /// * Example to register:
    /// ```
    /// let builder = GroupDefinitions {
    ///     Definition("home").object(HomeViewController())
    ///     Definition("file").object(FileViewController())
    ///     Definition("me").object(MeViewController())
    /// }
    /// .alias(UIViewController.self)
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[UIViewController.self, name: "home"]
    /// context[UIViewController.self, name: "file"]
    /// context[UIViewController.self, name: "me"]
    /// ```
    ///
    /// - Parameter protocolType: Protocol implemented by the resolved object or the type of the
    /// resolved object
    /// - Returns: DefinitionBuilder that can group other DefinitionBuilders
    public func alias(_ protocolType: Any.Type) -> Self {
        builders.forEach { builder in
            if builder.definition.protocolAlias == nil {
                builder.definition.protocolTypeAlias = [protocolType]
            } else {
                builder.definition.protocolTypeAlias?.append(protocolType)
            }
        }
        return self
    }
    
    /// Set the alias protocols of all the DefinitionBuilders in the group
    ///
    /// * Example to register:
    /// ```
    /// let builder = GroupDefinitions {
    ///     Definition("home").object(HomeViewController())
    ///     Definition("file").object(FileViewController())
    ///     Definition("me").object(MeViewController())
    /// }
    /// .alias([BaseViewController.self, UIViewController.self])
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[UIViewController.self, name: "home"]
    /// context[BaseViewController.self, name: "file"]
    /// context[BaseViewController.self, name: "me"]
    /// ```
    ///
    /// - Parameter alias: Protocols implemented by the resolved object or the types of the
    /// resolved object
    /// - Returns: DefinitionBuilder that can group other DefinitionBuilders
    public func alias(_ alias: [Any.Type]) -> Self {
        builders.forEach { $0.definition.protocolTypeAlias = alias }
        return self
    }
    
    
    /// Set the scope (life cycle) of all the DefinitionBuilders in the group
    ///
    /// * Example to register:
    /// ```
    /// let builder = GroupDefinitions {
    ///     Definition().protocol(HomeVC.self).object(HomeViewController())
    ///     Definition().protocol(FileVC.self).object(FileViewController())
    ///     Definition().protocol(MeVC.self).object(MeViewController())
    /// }
    /// .scope(.singleton)
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[HomeVC.self]
    /// context[FileVC.self]
    /// context[MeVC.self]
    /// ```
    ///
    /// - Parameter scope: Scope (life cycle) of the object
    /// - Returns: DefinitionBuilder that can group other DefinitionBuilders
    @discardableResult
    public func scope(_ scope: ObjectScope) -> Self {
        builders.forEach { $0.definition.scope = scope }
        return self
    }
    
    /// Set the callback action for the completion of object resolving of all the DefinitionBuilders in the group
    ///
    /// * Example to register:
    /// ```
    /// let builder = GroupDefinitions {
    ///     Definition().protocol(HomeVC.self).object(HomeViewController())
    ///     Definition().protocol(FileVC.self).object(FileViewController())
    ///     Definition().protocol(MeVC.self).object(MeViewController())
    /// }
    /// .completed { _, _ in
    ///     Logger.pageView("root")
    /// }
    /// context.register(builder: builder)
    /// ```
    ///
    /// * Example to resolve:
    /// ```
    /// context[HomeVC.self]
    /// context[FileVC.self]
    /// context[MeVC.self]
    /// ```
    ///
    /// - Parameter completed: Callback action for the completion of object resolving
    /// - Returns: DefinitionBuilder that can group other DefinitionBuilders
    @discardableResult
    public func completed(_ completed: @escaping (ObjectContext, Any) -> Void) -> Self {
        builders.forEach { builder in
            if builder.definition.actions == nil {
                builder.definition.actions = [completed]
            } else {
                builder.definition.actions?.append(completed)
            }
        }
        return self
    }
}
