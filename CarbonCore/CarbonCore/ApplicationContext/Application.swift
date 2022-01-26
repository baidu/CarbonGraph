//
//  Application.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit

/// Use Application instead of UIApplication in the main function to automatically create an application context
/// with module scanning
open class Application: UIApplication {
    
    /// Create a default application context
    /// - Returns: An application context with module scanning.
    open override class func makeApplicationContext() -> ApplicationContext {
        ApplicationContext(moduleScan: true)
    }
    
    /// Create application and trigger the creation of the context
    override public init() {
        super.init()
        _ = context
    }
    
}
