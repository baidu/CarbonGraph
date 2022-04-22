//
//  UIApplication.Context.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit

/// Global application context that the application manages
public let appContext = UIApplication.shared.context

extension UIApplication {
    
    private static var _context: ApplicationContext?
    private static var context: ApplicationContext {
        if let context = UIApplication._context {
            return context
        } else {
            let context = makeApplicationContext()
            UIApplication._context = context
            return context
        }
    }
    
    /// Creates the application context that the application manages
    /// - Returns: A custom application context
    ///
    /// This is where subclasses should create their custom application context. You should never call this
    /// method directly. The application calls this method when its context property is requested but is
    /// currently nil.
    @objc open class func makeApplicationContext() -> ApplicationContext {
        ApplicationContext(moduleScan: false)
    }
    
    /// The context that the application manages
    ///
    /// If you access this property and its value is currently nil, the application automatically calls the
    /// ``makeApplicationContext()`` method and returns the resulting context.
    ///
    /// - Note: It's not thread-safe, do not use it in a multi-threaded environment.
    /// Use ``appContext`` instead.
    @objc public var context: ApplicationContext {
        return type(of: self).context
    }
    
}
