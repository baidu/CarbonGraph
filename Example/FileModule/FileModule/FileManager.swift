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
    
    func recentFileModels() -> Array<FileModelProtocol> {
        var fileModels = Array<FileModelProtocol>()
        // --- Just for testing
        if let fileModel = appContext[FileModelProtocol.self] {
            fileModel.filePath = "Travel/Beijing"
            fileModel.fileName = "IMG_0162.HEIC"
            fileModels.append(fileModel)
        }
        if let fileModel = appContext[FileModelProtocol.self, "Home/NewYear", "IMG_4478.mov"] {
            fileModels.append(fileModel)
        }
        // ---
        return fileModels
    }
}
