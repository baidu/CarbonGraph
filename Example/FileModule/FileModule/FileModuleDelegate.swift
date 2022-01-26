//
//  FileModuleDelegate.swift
//  FileModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation
import CarbonCore
import BasicModule
import UIKit

class FileModuleDelegate: ScannableModuleConfiguration {
    static func definitions(of context: ObjectContext) -> Definitions {
        Definition()
            .protocol(FileModelProtocol.self)
            .constructor(FileModel.init(filePath:))
        
        Definition()
            .constructor(FilePath.init)
        
        Definition()
            .factory(fileModel2(context:arg1:arg2:))
        
        Definition()
            .protocol(FileManagerProtocol.self)
            .factory { _ in FileManager() }
        
        Definition()
            .protocol(FileViewControllerProtocol.self)
            .factory { _ in FileViewController() }
            .property(\.avatarFactory)
    }
}

extension ModuleDelegate {
    static func fileModel2(context: ObjectContext, arg1: String, arg2: String) -> FileModelProtocol {
        FileModel(path: arg1, name: arg2)
    }
}
