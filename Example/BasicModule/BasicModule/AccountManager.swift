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
        // Login with 65803387
        accountInfo = AccountModel(name: "65803387", avatarImage: UIImage(named: "avatar"), paymentType: .svip)
    }
    
    @objc public static func shared() -> AccountManager {
        return AccountManager()
    }
    
    @objc public var accountInfo: AccountModelProtocol?
    
}
