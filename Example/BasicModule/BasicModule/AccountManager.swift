//
//  AccountManager.swift
//  BasicModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit

@objc public class AccountManager: NSObject, AccountManagerProtocol {
    
    private override init() {
        accountInfo = AccountModel(name: "CarbonGraph is a Swift dependency injection / lookup framework for iOS. You can use it to build loose coupling between modules.", avatarImage: UIImage(named: "launch_screen"), paymentType: .svip)
    }
    
    @objc public static func shared() -> AccountManager {
        return AccountManager()
    }
    
    @objc public var accountInfo: AccountModelProtocol?
    
}
