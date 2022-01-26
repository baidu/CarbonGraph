//
//  FileManager.swift
//  FileModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit
import BasicModule
import CarbonCore

class FileManager: NSObject, FileManagerProtocol {
    
    func fileModels(_ fileModel: FileModelProtocol? = nil) -> Array<FileModelProtocol> {
        return []
    }
    
    func recentFileModels() -> Array<FileModelProtocol> {
        // MARK: S8: Protocol defined in Swift, registered in Swift, resolved in Swift
        var fileModels = Array<FileModelProtocol>()
        if let fileModel = appContext[FileModelProtocol.self] {
            fileModel.filePath = "c/d"
            fileModel.fileName = "test.txt"
            fileModels.append(fileModel)
        }
//        if let fileModel = appContext[FileModelProtocol.self, "/a/b.mp4"] {
//            fileModels.append(fileModel)
//        }
        if let fileModel = appContext[FileModelProtocol.self, "/a/b/", "c.mp4"] {
            fileModels.append(fileModel)
        }
        print("S8: \(String(describing: fileModels))")
        return fileModels
    }
}
