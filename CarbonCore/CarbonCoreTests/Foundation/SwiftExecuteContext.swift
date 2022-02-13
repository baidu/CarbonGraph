//
//  SwiftExecuteContext.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit
import CarbonCore

public class SwiftExecuteContext: NSObject {
    @objc public class func registerFileViewController(to context: ObjectContext) {
        let def = Definition()
            .protocol(FileViewControllerProtocol.self)
            .factory { _ in FileViewController() }
            .property(\.avatarFactory)
        context.register(builder: def)
    }
    
    @objc public class func registerFileManager(to context: ObjectContext) {
        let def = Definition()
            .protocol(FileManagerProtocol.self)
            .factory { _ in FileManager() }
        context.register(builder: def)
    }
}
