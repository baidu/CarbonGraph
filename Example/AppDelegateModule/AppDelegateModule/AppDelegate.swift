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
        
        if let homeVC = appContext[NSObjectProtocol.self, name: "homevc"] as? UIViewController {
            viewControllers.append(homeVC)
        }
        
        if let fileVC = appContext[NSObjectProtocol.self, name: "filevc"] as? UIViewController {
            viewControllers.append(fileVC)
        }
        
        if let meVC = appContext[NSObjectProtocol.self, name: "mevc"] as? UIViewController {
            viewControllers.append(meVC)
        }
        
        let tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.tabBar.backgroundColor = .lightGray
        tabBarController.tabBar.tintColor = .white
        tabBarController.viewControllers = viewControllers
        window?.rootViewController = tabBarController;
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
