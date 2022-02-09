//
//  ApplicationContext.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit

/// Application context with configuration and module management
@objc(CBNApplicationContext) public class ApplicationContext: ObjectContext {
    
    private var modules: [Module] = []
    
    /// Classes collected according to strategy classes
    @objc public let scannedClasses: [AnyClass]
    
    /// Created by default strategy
    ///
    /// When there is an ApplicationContext with moduleScan enabled in the project, Configuration classes
    /// and ModuleDelegate classes inherited from the ``ScannableObject`` will be automatically
    /// registered.
    ///
    /// - SeeAlso: ``ScannableConfiguration``, ``ScannableModuleConfiguration``
    ///
    /// - Parameters:
    ///   - defaultScope: The default life cycle of objects in the context.
    ///   - moduleScan: Whether to scan configuration classes according to the default
    /// ``ScannableObjectStrategy``.
    @objc public convenience init(defaultScope: ObjectScope = .default,
                                  moduleScan: Bool = false) {
        if moduleScan == true {
            self.init(defaultScope: defaultScope,
                      strategies: [ScannableObjectStrategy()])
        } else {
            self.init(defaultScope: defaultScope, strategies: [])
        }
    }
    
    /// Created by custom strategies
    /// - Parameter strategies: Scan configuration classes according to custom strategies.
    @objc public init(defaultScope: ObjectScope = .default,
                      strategies: [ScannableStrategy]) {
        if !strategies.isEmpty {
            Scanner.scan(strategies: strategies)
            scannedClasses = strategies.flatMap {$0.types}
        } else {
            scannedClasses = []
        }
        
        super.init(defaultScope: defaultScope)
        
        for anyClass in scannedClasses {
            // Directly using '$0 as? Configuration.Type' to determine
            // whether the class defined by ObjC implements the
            // configuration protocol will cause a crash on a
            // specific model.
            //
            // Known models:
            // * iPhone XR, MT122CH/A, A2108; iOS 15.0, 19A5297e
            let className = NSStringFromClass(anyClass)
            guard let safeClass = NSClassFromString(className) else { continue }
            
            if let delegateClass = safeClass as? ModuleDelegate.Type {
                register(delegate: delegateClass)
            } else if let configClass = safeClass as? Configuration.Type {
                register(configuration: configClass)
            }
        }
        registerNotifications()
    }
    
    /// Register module delegate
    ///
    /// If the delegate also implements the ``Configuration`` protocol, then the
    /// ``ObjectContext/register(configuration:)`` will also be called.
    ///
    /// - Note: It's not thread-safe, do not use it in a multi-threaded environment.
    ///
    /// - Parameter delegate: Class conforming to the ``ModuleDelegate`` protocol
    /// - Returns: Registered module
    @discardableResult
    @objc public func register(delegate: ModuleDelegate.Type) -> Module {
        if let configuration = delegate as? Configuration.Type {
            register(configuration: configuration)
        }
        let launchOptions = delegate.launchOptions?()
        let moduleLaunchOptions = ModuleLaunchOptions(delegateClass: delegate,
                                                      items: launchOptions)
        let moduleClass = moduleLaunchOptions.moduleClass
        let module = moduleClass.init(launchOptions: moduleLaunchOptions)
        let index = modules.firstIndex(where: {
            module.comparePriority(to: $0) == .orderedDescending
        }) ?? modules.endIndex
        modules.insert(module, at: index)
        return module
    }
    
    /// Batch registration of ``ModuleDelegate``
    ///
    /// Call the ``register(delegate:)`` for each ModuleDelegate type.
    ///
    /// - Note: It's not thread-safe, do not use it in a multi-threaded environment.
    /// - Parameter delegates: Classes conforming to the ModuleDelegate protocol
    /// - Returns: Registered ordered modules
    @discardableResult
    @objc public func register(delegates: [ModuleDelegate.Type]) -> [Module] {
        delegates.map { delegate in
            register(delegate: delegate)
        }.sorted { $0.comparePriority(to: $1) == .orderedDescending }
    }
    
    /// Load module
    ///
    /// Create the modue's delegate if not and call the ``ModuleDelegate/moduleDidFinishLaunching(_:)``.
    ///
    /// - Parameter module_: Module to be loaded
    /// - Returns: Whether the load is successful
    @discardableResult
    @objc public func load(module: Module) -> Bool {
        if module.delegate == nil {
            module.delegate = module.launchOptions.delegateClass.init()
            module.delegate?.moduleDidFinishLaunching?(module)
            return true
        }
        return false
    }
    
    /// Batch registration and loading ``ModuleDelegate``
    ///
    /// Call the ``register(delegate:)`` and ``load(module:)`` for each
    /// ModuleDelegate type.
    ///
    /// - Note: It's not thread-safe, do not use it in a multi-threaded environment.
    /// - Parameter delegates: Classes conforming to the ModuleDelegate protocol
    @objc public func registerAndLoad(delegates: [ModuleDelegate.Type]) {
        for module in register(delegates: delegates) {
            load(module: module)
        }
    }
    
    private var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    private func registerNotifications() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: nil,
            queue: .main
        ) { notification in
            for module in self.modules {
                module.delegate?.applicationDidEnterBackground?(notification.object as? UIApplication ?? UIApplication.shared)
            }
        }
        NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: .main
        ) { notification in
            for module in self.modules {
                module.delegate?.applicationWillEnterForeground?(notification.object as? UIApplication ?? UIApplication.shared)
            }
        }
        NotificationCenter.default.addObserver(
            forName: UIApplication.didFinishLaunchingNotification,
            object: nil,
            queue: .main
        ) { notification in
            self.launchOptions = notification.userInfo as? [UIApplication.LaunchOptionsKey: Any]
            for module in self.modules {
                if module.launchOptions.lazyLoad == false {
                    self.load(module: module)
                }
            }
        }
        NotificationCenter.default.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: nil,
            queue: .main
        ) { notification in
            for module in self.modules {
                module.delegate?.applicationDidBecomeActive?(notification.object as? UIApplication ?? UIApplication.shared)
            }
        }
        NotificationCenter.default.addObserver(
            forName: UIApplication.willResignActiveNotification,
            object: nil,
            queue: .main
        ) { notification in
            for module in self.modules {
                module.delegate?.applicationWillResignActive?(notification.object as? UIApplication ?? UIApplication.shared)
            }
        }
        NotificationCenter.default.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: nil,
            queue: .main
        ) { notification in
            for module in self.modules {
                module.delegate?.moduleDidReceiveMemoryWarning?(module)
            }
        }
        NotificationCenter.default.addObserver(
            forName: UIApplication.willTerminateNotification,
            object: nil,
            queue: .main
        ) { notification in
            for module in self.modules {
                module.delegate?.moduleWillTerminate?(module)
            }
        }
        NotificationCenter.default.addObserver(
            forName: UIApplication.significantTimeChangeNotification,
            object: nil,
            queue: .main
        ) { notification in
            for module in self.modules {
                module.delegate?.applicationSignificantTimeChange?(notification.object as? UIApplication ?? UIApplication.shared)
            }
        }
    }
}
