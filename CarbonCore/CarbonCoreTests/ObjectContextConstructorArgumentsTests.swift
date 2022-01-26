//
//  ObjectContextConstructorArgumentsTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
@testable import CarbonCore

class ObjectContextConstructorArgumentsTests: XCTestCase {
    var context: ApplicationContext!
    
    override func setUpWithError() throws {
        context = ApplicationContext()
    }
    
    func testObjectContextAccepts1Argument() {
        let builder = Definition()
            .protocol(FileModelProtocol.self)
            .constructor(FileModel.init(filePath1:))
        
        let filePathBuilder = Definition()
            .constructor(FilePath.init)
        
        context.register(builder: builder)
        context.register(builder: filePathBuilder)
        let fileModel = context[FileModelProtocol.self]
        XCTAssertNotNil(fileModel?.filePath1)
        XCTAssertNil(fileModel?.filePath2)
    }
    
    func testObjectContextAccepts2Arguments() {
        let builder = Definition()
            .protocol(FileModelProtocol.self)
            .constructor(FileModel.init(filePath1:filePath2:))
        
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
            .constructor(FileModel.init(filePath1:filePath2:filePath3:))
        
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
            .constructor(FileModel.init(filePath1:filePath2:filePath3:filePath4:))
        
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
            .constructor(FileModel.init(filePath1:filePath2:filePath3:filePath4:filePath5:))
        
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
            .constructor(FileModel.init(filePath1:filePath2:filePath3:filePath4:filePath5:filePath6:))
        
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
            .constructor(FileModel.init(filePath1:filePath2:filePath3:filePath4:filePath5:filePath6:filePath7:))
        
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
            .constructor(FileModel.init(filePath1:filePath2:filePath3:filePath4:filePath5:filePath6:filePath7:filePath8:))
        
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
            .constructor(FileModel.init(filePath1:filePath2:filePath3:filePath4:filePath5:filePath6:filePath7:filePath8:filePath9:))
        
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
            .constructor(FileModel.init(filePath1:filePath2:filePath3:filePath4:filePath5:filePath6:filePath7:filePath8:filePath9:filePath10:))
        
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

