//
//  FileModel.swift
//  FileModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit
import BasicModule

struct FilePath {
    var path: String = "/"
    var name: String = ""
}

class FileModel : NSObject, FileModelProtocol {
    
    var filePath: String
    var fileName: String
    
    init(path: String, name: String) {
        filePath = path
        fileName = name
    }
    
    convenience init(filePath: FilePath) {
        self.init(path: filePath.path, name: filePath.name)
    }
    
    convenience init(path: String) {
        let nsPath = NSString(string: path)
        if nsPath.pathExtension.count == 0 {
            self.init(path: path, name: "")
        } else {
            let lastPathComponent = nsPath.lastPathComponent
            self.init(path: nsPath.deletingLastPathComponent, name: lastPathComponent)
        }
    }

}
