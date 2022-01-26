//
//  AppDelegate.swift
//  AppDelegateModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit
import HomeModule
import MeModule
import BasicModule
import CarbonCore

public class AppDelegate: UIResponder, UIApplicationDelegate  {
    
    lazy public var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        var viewControllers = Array<UIViewController>();
        
        if let homeVCService = appContext[HomeVCServiceProtocol.self] {
            viewControllers.append(homeVCService.homeViewController())
        }
        
        
        // MARK: S4: Protocol defined in ObjC, registered in Swift, resolved in Swift
        if let fileVC = appContext[FileViewControllerProtocol.self] as? UIViewController {
            viewControllers.append(fileVC)
            print("S4: \(String(describing: fileVC))")
        }
        
        if let meVCService = appContext[MeVCServiceProtocol.self] {
            viewControllers.append(meVCService.meViewController())
        }
        
        let tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.tabBar.backgroundColor = .lightGray
        tabBarController.tabBar.tintColor = .white
        tabBarController.viewControllers = viewControllers
        window?.rootViewController = tabBarController;
        window?.makeKeyAndVisible()
        
        
        // MARK: S6: Protocol defined in Swift, registered in ObjC, resolved in Swift
        let accountManager = appContext[AccountManagerProtocol.self]
        print("S6: \(String(describing: accountManager))")
        return true
    }
    
}
