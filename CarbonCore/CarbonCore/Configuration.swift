//
//  Configuration.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

#if swift(>=5.4)
/// Result builder for object context configuration
@resultBuilder public struct ConfigurationBuilder {
    public static func buildBlock(_ components: [DefinitionBuilder]...) -> [DefinitionBuilder] {
        return components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: GroupDefinitionBuilder) -> [DefinitionBuilder] {
        return expression.builders
    }
    
    public static func buildExpression(_ expression: DefinitionBuilder) -> [DefinitionBuilder] {
        return [expression]
    }
    
    public static func buildOptional(_ component: [DefinitionBuilder]?) -> [DefinitionBuilder] {
        return component ?? []
    }
    
    public static func buildEither(first component: [DefinitionBuilder]) -> [DefinitionBuilder] {
        return component
    }
    
    public static func buildEither(second component: [DefinitionBuilder]) -> [DefinitionBuilder] {
        return component
    }

    public static func buildArray(_ components: [[DefinitionBuilder]]) -> [DefinitionBuilder] {
        return components.flatMap { $0 }
    }
}
#else
@_functionBuilder public struct ConfigurationBuilder {
    public static func buildBlock(_ components: DefinitionBuilder...) -> [DefinitionBuilder] {
        return components
    }
}
#endif

/// Object context configuration protocol
///
/// Class implements this protocol to configure the object context.
/// Use the ``ObjectContext/register(configuration:)`` of ``ObjectContext`` to register.
public protocol Configuration {
    /// Define objects registered in the object context
    /// - Returns: object definitions
    @ConfigurationBuilder static func definitions(
        of context: ObjectContext
    ) -> Definitions
}
