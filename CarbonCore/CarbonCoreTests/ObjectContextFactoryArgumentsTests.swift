//
//  ObjectContextFactoryArgumentsTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
@testable import CarbonCore

class ObjectContextTestsFactory_Arguments: XCTestCase {
    var context: ApplicationContext!
    
    override func setUpWithError() throws {
        context = ApplicationContext()
    }

    func testObjectContextAccepts1Argument() {
        let builder = Definition()
            .protocol(Animal.self)
            .factory { _, arg1 in
                Persian(name: arg1)
            }
        context.register(builder: builder)
        let animal = context[Animal.self, "1"]
        XCTAssertEqual(animal?.name, "1")
    }
    
    func testObjectContextAccepts2Arguments() {
        let builder = Definition()
            .protocol(Animal.self)
            .factory { _, arg1, arg2 in
                Persian(name: arg1 + arg2)
            }
        context.register(builder: builder)
        let animal = context[Animal.self, "1", "2"]
        XCTAssertEqual(animal?.name, "12")
    }
    
    func testObjectContextAccepts3Arguments() {
        let builder = Definition()
            .protocol(Animal.self)
            .factory { _, arg1, arg2, arg3 in
                Persian(name: arg1 + arg2 + arg3)
            }
        context.register(builder: builder)
        let animal = context[Animal.self, "1", "2", "3"]
        XCTAssertEqual(animal?.name, "123")
    }
    
    func testObjectContextAccepts4Arguments() {
        let builder = Definition()
            .protocol(Animal.self)
            .factory { _, arg1, arg2, arg3, arg4 in
                Persian(name: arg1 + arg2 + arg3 + arg4)
            }
        context.register(builder: builder)
        let animal = context[Animal.self, "1", "2", "3", "4"]
        XCTAssertEqual(animal?.name, "1234")
    }
    
    func testObjectContextAccepts5Arguments() {
        let builder = Definition()
            .protocol(Animal.self)
            .factory { _, arg1, arg2, arg3, arg4, arg5 in
                Persian(name: arg1 + arg2 + arg3 + arg4 + arg5)
            }
        context.register(builder: builder)
        let animal = context[Animal.self, "1", "2", "3", "4", "5"]
        XCTAssertEqual(animal?.name, "12345")
    }
    
    func testObjectContextAccepts6Arguments() {
        let builder = Definition()
            .protocol(Animal.self)
            .factory { _, arg1, arg2, arg3, arg4, arg5, arg6 in
                Persian(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6)
            }
        context.register(builder: builder)
        let animal = context[Animal.self, "1", "2", "3", "4", "5", "6"]
        XCTAssertEqual(animal?.name, "123456")
    }
    
    func testObjectContextAccepts7Arguments() {
        let builder = Definition()
            .protocol(Animal.self)
            .factory { _, arg1, arg2, arg3, arg4, arg5, arg6, arg7 in
                Persian(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7)
            }
        context.register(builder: builder)
        let animal = context[Animal.self, "1", "2", "3", "4", "5", "6", "7"]
        XCTAssertEqual(animal?.name, "1234567")
    }
    
    func testObjectContextAccepts8Arguments() {
        let builder = Definition()
            .protocol(Animal.self)
            .factory { _, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 in
                Persian(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7 + arg8)
            }
        context.register(builder: builder)
        let animal = context[Animal.self, "1", "2", "3", "4", "5", "6", "7", "8"]
        XCTAssertEqual(animal?.name, "12345678")
    }
    
    func testObjectContextAccepts9Arguments() {
        let builder = Definition()
            .protocol(Animal.self)
            .factory { _, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 in
                Persian(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7 + arg8 + arg9)
            }
        context.register(builder: builder)
        let animal = context[Animal.self, "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        XCTAssertEqual(animal?.name, "123456789")
    }
    
    func testObjectContextAccepts10Arguments() {
        let builder = Definition()
            .protocol(Animal.self)
            .factory { _, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 in
                Persian(name: arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7 + arg8 + arg9 + arg10)
            }
        context.register(builder: builder)
        let animal = context[Animal.self, "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        XCTAssertEqual(animal?.name, "12345678910")
    }
}

