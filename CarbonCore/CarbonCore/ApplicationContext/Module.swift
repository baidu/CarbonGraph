//
//  Module.swift
//  CarbonCore
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

/// Module class, save the basic information of the module defined in ``ModuleDelegate``
@objc(CBNModule) public class Module: NSObject {
    
    let launchOptions: ModuleLaunchOptions
    var delegate: ModuleDelegate?
    
    
    /// Module name defined in ``ModuleDelegate``
    @objc public var name: String {
        launchOptions.name
    }
    
    required init(launchOptions: ModuleLaunchOptions) {
        self.launchOptions = launchOptions
    }
    
    /// Determine the priority of the two modules
    ///
    /// Modules that do not load lazily are bigger. If the value of lazyLoad is the same, the value of priority
    /// property determines which is bigger
    ///
    /// - Returns: Constants that indicate sort order from left to right in code
    public func comparePriority(to module: Module) -> ComparisonResult {
        let l = self.launchOptions
        switch module.launchOptions {
        case let r where l.lazyLoad == true && r.lazyLoad == false:
            return .orderedAscending
        case let r where l.lazyLoad == false && r.lazyLoad == true:
            return .orderedDescending
        case let r where l.priority.rawValue < r.priority.rawValue:
            return .orderedAscending
        case let r where l.priority.rawValue > r.priority.rawValue:
            return .orderedDescending
        default:
            return .orderedSame
        }
    }
    
}

/// Module priority
///
/// The larger the value, the higher the priority, the earlier it will be loaded
@objc(CBNModulePriority) public enum ModulePriority: Int {
    case `default` = 0
    case business = 1000
    case services = 2000
    case foundation = 3000
    case system = 10000
}

class ModuleLaunchOptions {
    
    let name: String
    let priority: ModulePriority
    let moduleClass: Module.Type
    let delegateClass: ModuleDelegate.Type
    let lazyLoad: Bool
    
    init(delegateClass: ModuleDelegate.Type,
         items: [ModuleLaunchOptionsItem]?) {
        self.delegateClass = delegateClass
        
        var nameValue: String?
        var priorityValue: ModulePriority?
        var moduleClassValue: Module.Type?
        var lazyLoadValue: Bool?
        
        for item in items ?? [] {
            switch item.key {
            case .name:
                nameValue = item.value as? String
            case .priority:
                priorityValue = item.value as? ModulePriority
            case .cls:
                moduleClassValue = item.value as? Module.Type
            case .lazyLoad:
                lazyLoadValue = item.value as? Bool
            }
        }
        
        name = nameValue ?? String(reflecting: delegateClass)
        priority = priorityValue ?? .default
        moduleClass = moduleClassValue ?? Module.self
        lazyLoad = lazyLoadValue ?? false
    }
    
}

/// One item of module configuration
///
/// You can use different constructors to create different configuration items
@objc(CBNModuleLaunchOptionsItem) public class ModuleLaunchOptionsItem: NSObject {
    
    enum Key {
        case name
        case priority
        case cls
        case lazyLoad
    }
    
    let key: Key
    let value: Any
    
    /// Create module name configuration item
    /// - Parameter name: Module name
    @objc(itemWithName:) static public func name(
        _ name: String
    ) -> ModuleLaunchOptionsItem {
        ModuleLaunchOptionsItem(name: name)
    }
    
    private init(name: String) {
        key = .name
        value = name
    }
    
    /// Create module priority configuration item
    /// - Parameter priority: Module priority
    @objc(itemWithPriority:) static public func priority(
        _ priority: ModulePriority
    ) -> ModuleLaunchOptionsItem {
        ModuleLaunchOptionsItem(priority: priority)
    }
    
    private init(priority: ModulePriority) {
        key = .priority
        value = priority
    }
    
    /// Create module class configuration item
    /// - Parameter cls: Module class
    @objc(itemWithCls:) static public func cls(
        _ cls: Module.Type
    ) -> ModuleLaunchOptionsItem {
        ModuleLaunchOptionsItem(cls: cls)
    }
    
    private init(cls: Module.Type) {
        key = .cls
        value = cls
    }
    
    /// Create module lazy loading configuration item
    /// - Parameter lazyLoad: Whether the module is loaded lazily
    @objc(itemWithLazyLoad:) static public func lazyLoad(
        _ lazyLoad: Bool
    ) -> ModuleLaunchOptionsItem {
        ModuleLaunchOptionsItem(lazyLoad: lazyLoad)
    }
    
    private init(lazyLoad: Bool) {
        key = .lazyLoad
        value = lazyLoad
    }
    
}
