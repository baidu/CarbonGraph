//
//  SwiftCmpatibilityFoundation.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit

@objc public protocol AccountManagerProtocol: NSObjectProtocol {}

@objc public class AccountManager: NSObject, AccountManagerProtocol {}

@objc public protocol FileManagerProtocol: NSObjectProtocol {}

class FileManager: NSObject, FileManagerProtocol {}

class FileViewController: UIViewController, FileViewControllerProtocol {
    var avatarFactory: AvatarFactoryProtocol?
}
