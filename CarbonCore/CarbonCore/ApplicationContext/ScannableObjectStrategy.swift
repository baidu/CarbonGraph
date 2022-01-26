//
//  ScannableObjectStrategy.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit

/// The strategy that collect all scanable classes (Inherited from ``ScannableObject``)
public class ScannableObjectStrategy: NSObject, ScannableStrategy {
    
    required public override init() {}
    
    /// Collected types
    public var types: [AnyClass] = []
    
    /// Matching method
    ///
    /// Determine whether it is inherited from ``ScannableObject``. Subclasses can override
    /// this method to implement custom matching rules, return yes will call the
    /// ``handle(anyClass:)`` method to process.
    ///
    /// - Parameter anyClass: Any class in the project
    /// - Returns: Does it match
    public func isMatched(anyClass: AnyClass) -> Bool {
        class_getSuperclass(anyClass) == ScannableObject.self
    }
    
    /// Processing method
    ///
    /// Store the collected type. Subclasses can override this method to implement custom processing.
    ///
    /// - Parameter anyClass: Matched type
    public func handle(anyClass: AnyClass) {
        types.append(anyClass)
    }
    
}
