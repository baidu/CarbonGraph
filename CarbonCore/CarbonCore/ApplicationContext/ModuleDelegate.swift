//
//  ModuleDelegate.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit

/// A set of methods to manage shared behaviors for your module
@objc(CBNModuleDelegate) public protocol ModuleDelegate {
    
    /// The required initializer
    ///
    /// The class that implements the ``ModuleDelegate`` protocol must have the ability to be created
    /// by the framework.
    @objc init()
    
    /// Configure the basic information of the module
    /// - Returns: A set of  items to define the basic information of the module
    @objc optional static func launchOptions() -> [ModuleLaunchOptionsItem]
    
    /// Tells the delegate that the module loading process is almost done
    ///
    /// Use this method to complete your module’s initialization and make any final tweaks.
    /// At some point after this method returns, the system calls another of your app delegate’s methods
    /// to move the app to the active (foreground) state or the background state.
    ///
    /// - Note: If the ``ApplicationContext`` with module scanning is created before the
    /// App launching, all modules without lazy-load will be automatically loaded, and this method
    /// will be called. Otherwise, you need to manually call the ``ApplicationContext/load(module:)`` of
    /// ApplicationContext to load the module.
    ///
    /// - Parameter module_: The current module object
    @objc optional func moduleDidFinishLaunching(_ module: Module)
    
    /// Tells the delegate when the app receives a memory warning from the system
    /// - Parameter module_: The current module object
    @objc optional func moduleDidReceiveMemoryWarning(_ module: Module)
    
    /// Tells the delegate when the app is about to terminate
    /// - Parameter module_: The current module object
    @objc optional func moduleWillTerminate(_ module: Module)
    
    /// Tells the delegate that the app is now in the background
    /// - Parameter application: The singleton app object
    @objc optional func applicationDidEnterBackground(_ application: UIApplication)
    
    /// Tells the delegate that the app is about to enter the foreground
    /// - Parameter application: The singleton app object
    @objc optional func applicationWillEnterForeground(_ application: UIApplication)
    
    /// Tells the delegate that the app has become active
    /// - Parameter application: The singleton app object
    @objc optional func applicationDidBecomeActive(_ application: UIApplication)
    
    /// Tells the delegate that the app is about to become inactive
    /// - Parameter application: The singleton app object
    @objc optional func applicationWillResignActive(_ application: UIApplication)
    
    /// Tells the delegate when there is a significant change in the time.
    /// - Parameter application: The singleton app object
    @objc optional func applicationSignificantTimeChange(_ application: UIApplication)
    
}

/// Implement ``ModuleDelegate`` and ``Configuration`` protocols
public typealias ModuleConfiguration = ModuleDelegate & Configuration
