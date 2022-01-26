//
//  ObjectContextSetterArgumentsTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
@testable import CarbonCore

class ObjectContextSetterArgumentsTests: XCTestCase {
    var context: ApplicationContext!
    
    override func setUpWithError() throws {
        context = ApplicationContext(moduleScan: false)
    }
    
    func testObjectContextAccepts1Argument() {
        let builder = Definition()
            .protocol(FileModelProtocol.self)
            .factory { _ in
                FileModel()
            }.setter(FileModel.setPath(path1:))
        
        let pathBuilder = Definition()
            .constructor(FilePath.init)
        
        context.register(builder: builder)
        context.register(builder: pathBuilder)
        let fileModel = context[FileModelProtocol.self]
        XCTAssertNotNil(fileModel?.filePath1)
        XCTAssertNil(fileModel?.filePath2)
    }
    
    func testObjectContextAccepts2Arguments() {
        let builder = Definition()
            .protocol(FileModelProtocol.self)
            .factory { _ in
                FileModel()
            }.setter(FileModel.setPath(path1:path2:))
        
        let filePathBuilder = Definition()
            .constructor(FilePath.init)
        
        context.register(builder: builder)
        context.register(builder: filePathBuilder)
        let fileModel = context[FileModelProtocol.self]
        XCTAssertNotNil(fileModel?.filePath1)
        XCTAssertNotNil(fileModel?.filePath2)
    }
    
    func testObjectContextAccepts3Arguments() {
        let builder = Definition()
            .protocol(FileModelProtocol.self)
            .factory { _ in
                FileModel()
            }.setter(FileModel.setPath(path1:path2:path3:))
        
        let filePathBuilder = Definition()
            .constructor(FilePath.init)
        
        context.register(builder: builder)
        context.register(builder: filePathBuilder)
        let fileModel = context[FileModelProtocol.self]
        XCTAssertNotNil(fileModel?.filePath1)
        XCTAssertNotNil(fileModel?.filePath2)
        XCTAssertNotNil(fileModel?.filePath3)
    }
    
    func testObjectContextAccepts4Arguments() {
        let builder = Definition()
            .protocol(FileModelProtocol.self)
            .factory { _ in
                FileModel()
            }.setter(FileModel.setPath(path1:path2:path3:path4:))
        
        let filePathBuilder = Definition()
            .constructor(FilePath.init)
        
        context.register(builder: builder)
        context.register(builder: filePathBuilder)
        let fileModel = context[FileModelProtocol.self]
        XCTAssertNotNil(fileModel?.filePath1)
        XCTAssertNotNil(fileModel?.filePath2)
        XCTAssertNotNil(fileModel?.filePath3)
        XCTAssertNotNil(fileModel?.filePath4)
    }
    
    func testObjectContextAccepts5Arguments() {
        let builder = Definition()
            .protocol(FileModelProtocol.self)
            .factory { _ in
                FileModel()
            }.setter(FileModel.setPath(path1:path2:path3:path4:path5:))
        
        let filePathBuilder = Definition()
            .constructor(FilePath.init)
        
        context.register(builder: builder)
        context.register(builder: filePathBuilder)
        let fileModel = context[FileModelProtocol.self]
        XCTAssertNotNil(fileModel?.filePath1)
        XCTAssertNotNil(fileModel?.filePath2)
        XCTAssertNotNil(fileModel?.filePath3)
        XCTAssertNotNil(fileModel?.filePath4)
        XCTAssertNotNil(fileModel?.filePath5)
    }
    
    func testObjectContextAccepts6Arguments() {
        let builder = Definition()
            .protocol(FileModelProtocol.self)
            .factory { _ in
                FileModel()
            }.setter(FileModel.setPath(path1:path2:path3:path4:path5:path6:))
        
        let filePathBuilder = Definition()
            .constructor(FilePath.init)
        
        context.register(builder: builder)
        context.register(builder: filePathBuilder)
        let fileModel = context[FileModelProtocol.self]
        XCTAssertNotNil(fileModel?.filePath1)
        XCTAssertNotNil(fileModel?.filePath2)
        XCTAssertNotNil(fileModel?.filePath3)
        XCTAssertNotNil(fileModel?.filePath4)
        XCTAssertNotNil(fileModel?.filePath5)
        XCTAssertNotNil(fileModel?.filePath6)
    }
    
    func testObjectContextAccepts7Arguments() {
        let builder = Definition()
            .protocol(FileModelProtocol.self)
            .factory { _ in
                FileModel()
            }.setter(FileModel.setPath(path1:path2:path3:path4:path5:path6:path7:))
        
        let filePathBuilder = Definition()
            .constructor(FilePath.init)
        
        context.register(builder: builder)
        context.register(builder: filePathBuilder)
        let fileModel = context[FileModelProtocol.self]
        XCTAssertNotNil(fileModel?.filePath1)
        XCTAssertNotNil(fileModel?.filePath2)
        XCTAssertNotNil(fileModel?.filePath3)
        XCTAssertNotNil(fileModel?.filePath4)
        XCTAssertNotNil(fileModel?.filePath5)
        XCTAssertNotNil(fileModel?.filePath6)
        XCTAssertNotNil(fileModel?.filePath7)
    }
    
    func testObjectContextAccepts8Arguments() {
        let builder = Definition()
            .protocol(FileModelProtocol.self)
            .factory { _ in
                FileModel()
            }.setter(FileModel.setPath(path1:path2:path3:path4:path5:path6:path7:path8:))
        
        let filePathBuilder = Definition()
            .constructor(FilePath.init)
        
        context.register(builder: builder)
        context.register(builder: filePathBuilder)
        let fileModel = context[FileModelProtocol.self]
        XCTAssertNotNil(fileModel?.filePath1)
        XCTAssertNotNil(fileModel?.filePath2)
        XCTAssertNotNil(fileModel?.filePath3)
        XCTAssertNotNil(fileModel?.filePath4)
        XCTAssertNotNil(fileModel?.filePath5)
        XCTAssertNotNil(fileModel?.filePath6)
        XCTAssertNotNil(fileModel?.filePath7)
        XCTAssertNotNil(fileModel?.filePath8)
    }
    
    func testObjectContextAccepts9Arguments() {
        let builder = Definition()
            .protocol(FileModelProtocol.self)
            .factory { _ in
                FileModel()
            }.setter(FileModel.setPath(path1:path2:path3:path4:path5:path6:path7:path8:path9:))
        
        let filePathBuilder = Definition()
            .constructor(FilePath.init)
        
        context.register(builder: builder)
        context.register(builder: filePathBuilder)
        let fileModel = context[FileModelProtocol.self]
        XCTAssertNotNil(fileModel?.filePath1)
        XCTAssertNotNil(fileModel?.filePath2)
        XCTAssertNotNil(fileModel?.filePath3)
        XCTAssertNotNil(fileModel?.filePath4)
        XCTAssertNotNil(fileModel?.filePath5)
        XCTAssertNotNil(fileModel?.filePath6)
        XCTAssertNotNil(fileModel?.filePath7)
        XCTAssertNotNil(fileModel?.filePath8)
        XCTAssertNotNil(fileModel?.filePath9)
    }
    
    func testObjectContextAccepts10Arguments() {
        let builder = Definition()
            .protocol(FileModelProtocol.self)
            .factory { _ in
                FileModel()
            }.setter(FileModel.setPath(path1:path2:path3:path4:path5:path6:path7:path8:path9:path10:))
        
        let filePathBuilder = Definition()
            .constructor(FilePath.init)
        
        context.register(builder: builder)
        context.register(builder: filePathBuilder)
        let fileModel = context[FileModelProtocol.self]
        XCTAssertNotNil(fileModel?.filePath1)
        XCTAssertNotNil(fileModel?.filePath2)
        XCTAssertNotNil(fileModel?.filePath3)
        XCTAssertNotNil(fileModel?.filePath4)
        XCTAssertNotNil(fileModel?.filePath5)
        XCTAssertNotNil(fileModel?.filePath6)
        XCTAssertNotNil(fileModel?.filePath7)
        XCTAssertNotNil(fileModel?.filePath8)
        XCTAssertNotNil(fileModel?.filePath9)
        XCTAssertNotNil(fileModel?.filePath10)
    }
}


