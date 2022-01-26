//
//  AccountManagerProtocol.swift
//  BasicModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation

@objc public protocol AccountManagerProtocol: NSObjectProtocol {
    
    static func shared() -> AccountManager
    
    var accountInfo: AccountModelProtocol? { get set }
    
}
