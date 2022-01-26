//
//  ScannableObject.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

/// The class that can be scanned
///
/// Inherited from this class can be collected by ``ScannableStrategy``.
/// In most cases, it is used with the Configuration and ModuleDelegate protocols to be automatically
/// registered by the ApplicationContext.
///
/// - SeeAlso: ``ScannableConfiguration``, ``ScannableModuleConfiguration``
open class ScannableObject: NSObject {
    
    /// The required initializer
    ///
    /// The classes collected by ScannableStrategy must have the ability to be created by the framework.
    required public override init() {}
}

/// Inherit from ``ScannableObject`` and implement ``Configuration`` protocol
public typealias ScannableConfiguration = ScannableObject & Configuration

/// Inherit from ``ScannableObject`` and implement ``ModuleConfiguration`` protocol
public typealias ScannableModuleConfiguration = ScannableObject & ModuleConfiguration
