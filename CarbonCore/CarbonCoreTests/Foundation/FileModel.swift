//
//  FileModel.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit

public struct FilePath {
    var path: String = "/"
}

class FileModel: NSObject, FileModelProtocol {
    var filePath1: String?
    var filePath2: String?
    var filePath3: String?
    var filePath4: String?
    var filePath5: String?
    var filePath6: String?
    var filePath7: String?
    var filePath8: String?
    var filePath9: String?
    var filePath10: String?
    
    override init() {
        super.init()
    }
    
    func setPath(path1: FilePath) {
        filePath1 = path1.path
    }
    
    func setPath(path1: FilePath, path2: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
    }
    
    func setPath(path1: FilePath, path2: FilePath, path3: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
    }

    func setPath(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
    }
    
    func setPath(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath, path5: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
        filePath5 = path5.path
    }
    
    func setPath(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath, path5: FilePath, path6: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
        filePath5 = path5.path
        filePath6 = path6.path
    }
    
    func setPath(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath, path5: FilePath,
         path6: FilePath, path7: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
        filePath5 = path5.path
        filePath6 = path6.path
        filePath7 = path7.path
    }
    
    func setPath(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath, path5: FilePath,
         path6: FilePath, path7: FilePath, path8: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
        filePath5 = path5.path
        filePath6 = path6.path
        filePath7 = path7.path
        filePath8 = path8.path
    }
    
    func setPath(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath, path5: FilePath,
         path6: FilePath, path7: FilePath, path8: FilePath, path9: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
        filePath5 = path5.path
        filePath6 = path6.path
        filePath7 = path7.path
        filePath8 = path8.path
        filePath9 = path9.path
    }
    
    func setPath(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath, path5: FilePath,
         path6: FilePath, path7: FilePath, path8: FilePath, path9: FilePath, path10: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
        filePath5 = path5.path
        filePath6 = path6.path
        filePath7 = path7.path
        filePath8 = path8.path
        filePath9 = path9.path
        filePath10 = path10.path
    }
    
    init(path1: FilePath) {
        filePath1 = path1.path
    }
    
    init(path1: FilePath, path2: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
    }
    
    init(path1: FilePath, path2: FilePath, path3: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
    }

    init(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
    }
    
    init(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath, path5: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
        filePath5 = path5.path
    }
    
    init(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath, path5: FilePath, path6: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
        filePath5 = path5.path
        filePath6 = path6.path
    }
    
    init(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath, path5: FilePath,
         path6: FilePath, path7: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
        filePath5 = path5.path
        filePath6 = path6.path
        filePath7 = path7.path
    }
    
    init(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath, path5: FilePath,
         path6: FilePath, path7: FilePath, path8: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
        filePath5 = path5.path
        filePath6 = path6.path
        filePath7 = path7.path
        filePath8 = path8.path
    }
    
    init(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath, path5: FilePath,
         path6: FilePath, path7: FilePath, path8: FilePath, path9: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
        filePath5 = path5.path
        filePath6 = path6.path
        filePath7 = path7.path
        filePath8 = path8.path
        filePath9 = path9.path
    }
    
    init(path1: FilePath, path2: FilePath, path3: FilePath, path4: FilePath, path5: FilePath,
         path6: FilePath, path7: FilePath, path8: FilePath, path9: FilePath, path10: FilePath) {
        filePath1 = path1.path
        filePath2 = path2.path
        filePath3 = path3.path
        filePath4 = path4.path
        filePath5 = path5.path
        filePath6 = path6.path
        filePath7 = path7.path
        filePath8 = path8.path
        filePath9 = path9.path
        filePath10 = path10.path
    }
    
    convenience init(filePath1: FilePath) {
        self.init(path1: filePath1)
    }
    
    convenience init(filePath1: FilePath, filePath2: FilePath) {
        self.init(path1: filePath1, path2: filePath2)
    }
    
    convenience init(filePath1: FilePath, filePath2: FilePath, filePath3: FilePath) {
        self.init(path1: filePath1, path2: filePath2, path3: filePath3)
    }
    
    convenience init(filePath1: FilePath, filePath2: FilePath, filePath3: FilePath, filePath4: FilePath) {
        self.init(path1: filePath1, path2: filePath2, path3: filePath3, path4: filePath4)
    }
    
    convenience init(filePath1: FilePath, filePath2: FilePath, filePath3: FilePath, filePath4: FilePath, filePath5: FilePath) {
        self.init(path1: filePath1, path2: filePath2, path3: filePath3, path4: filePath4, path5: filePath5)
    }
    
    convenience init(filePath1: FilePath, filePath2: FilePath, filePath3: FilePath, filePath4: FilePath, filePath5: FilePath, filePath6: FilePath) {
        self.init(path1: filePath1, path2: filePath2, path3: filePath3, path4: filePath4, path5: filePath5, path6: filePath6)
    }

    convenience init(filePath1: FilePath, filePath2: FilePath, filePath3: FilePath, filePath4: FilePath, filePath5: FilePath, filePath6: FilePath, filePath7: FilePath) {
        self.init(path1: filePath1, path2: filePath2, path3: filePath3, path4: filePath4, path5: filePath5, path6: filePath6, path7: filePath7)
    }
    
    convenience init(filePath1: FilePath, filePath2: FilePath, filePath3: FilePath, filePath4: FilePath, filePath5: FilePath, filePath6: FilePath, filePath7: FilePath, filePath8: FilePath) {
        self.init(path1: filePath1, path2: filePath2, path3: filePath3, path4: filePath4, path5: filePath5, path6: filePath6, path7: filePath7, path8: filePath8)
    }
    
    convenience init(filePath1: FilePath, filePath2: FilePath, filePath3: FilePath, filePath4: FilePath, filePath5: FilePath, filePath6: FilePath, filePath7: FilePath, filePath8: FilePath, filePath9: FilePath) {
        self.init(path1: filePath1, path2: filePath2, path3: filePath3, path4: filePath4, path5: filePath5, path6: filePath6, path7: filePath7, path8: filePath8, path9: filePath9)
    }
    
    convenience init(filePath1: FilePath, filePath2: FilePath, filePath3: FilePath, filePath4: FilePath, filePath5: FilePath, filePath6: FilePath, filePath7: FilePath, filePath8: FilePath, filePath9: FilePath, filePath10: FilePath) {
        self.init(path1: filePath1, path2: filePath2, path3: filePath3, path4: filePath4, path5: filePath5, path6: filePath6, path7: filePath7, path8: filePath8, path9: filePath9, path10: filePath10)
    }
}

