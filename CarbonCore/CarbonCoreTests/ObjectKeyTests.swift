//
//  ObjectKeyTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
@testable import CarbonCore

// MARK: ObjectKeySpec

class ObjectKeyTests: XCTestCase {
    
    // MARK: Without name no args
    
    func testObjectKeyEqualsWithTheSameFactoryTypeNoArgs() {
        let key1 = ObjectKey(Animal.self)
        let key2 = ObjectKey(Animal.self)
        XCTAssertEqual(key1, key2)
        XCTAssertEqual(key1.hashValue, key2.hashValue)

        let key3 = ObjectKey(Animal.self, nil, (ObjectContext, String, Bool).self)
        let key4 = ObjectKey(Animal.self, nil, (ObjectContext, String, Bool).self)
        XCTAssertEqual(key3, key4)
        XCTAssertEqual(key3.hashValue, key4.hashValue)
    }

    func testObjectKeyDoesNotEqualWithDifferentprotocolTypesInFactoryTypesNoArgs() {
        let key1 = ObjectKey(Person.self)
        let key2 = ObjectKey(Animal.self)
        XCTAssertNotEqual(key1, key2)
        XCTAssertNotEqual(key1.hashValue, key2.hashValue)
    }

    // MARK: Without name args
    
    func testObjectKeyEqualsWithTheSameFactoryType() {
        let key1 = ObjectKey(Animal.self, nil, ObjectContext.self)
        let key2 = ObjectKey(Animal.self, nil, ObjectContext.self)
        XCTAssertEqual(key1, key2)
        XCTAssertEqual(key1.hashValue, key2.hashValue)

        let key3 = ObjectKey(Animal.self, nil, (ObjectContext, String, Bool).self)
        let key4 = ObjectKey(Animal.self, nil, (ObjectContext, String, Bool).self)
        XCTAssertEqual(key3, key4)
        XCTAssertEqual(key3.hashValue, key4.hashValue)
    }

    func testObjectKeyDoesNotEqualWithDifferentprotocolTypesInFactoryTypes() {
        let key1 = ObjectKey(Person.self, nil, ObjectContext.self)
        let key2 = ObjectKey(Animal.self, nil, ObjectContext.self)
        XCTAssertNotEqual(key1, key2)
        XCTAssertNotEqual(key1.hashValue, key2.hashValue)
    }

    func testObjectKeyDoesNotEqualWithDifferentArgTypesInFactoryTypes() {
        let key1 = ObjectKey(Animal.self, nil, (ObjectContext, String).self)
        let key2 = ObjectKey(Animal.self, nil, (ObjectContext, String, Bool).self)
        XCTAssertNotEqual(key1, key2)
        XCTAssertNotEqual(key1.hashValue, key2.hashValue)

        let key3 = ObjectKey(Animal.self, nil, (ObjectContext, String, Bool).self)
        let key4 = ObjectKey(Animal.self, nil, (ObjectContext, String, Int).self)
        XCTAssertNotEqual(key3, key4)
        XCTAssertNotEqual(key3.hashValue, key4.hashValue)
    }

    // MARK: With name no args
    
    func testObjectKeyEqualsWithTheSameNameNoArgs() {
        let key1 = ObjectKey(Animal.self, "my factory")
        let key2 = ObjectKey(Animal.self, "my factory")
        XCTAssertEqual(key1, key2)
        XCTAssertEqual(key1.hashValue, key2.hashValue)
        
        let key3 = ObjectKey(
            Animal.self,
            "my factory"
        )
        let key4 = ObjectKey(
            Animal.self,
            "my factory"
        )
        XCTAssertEqual(key3, key4)
        XCTAssertEqual(key3.hashValue, key4.hashValue)
    }

    func testObjectKeyDoesNotEqualWithDifferentNamesNoArgs() {
        let key1 = ObjectKey(Animal.self, "my factory")
        let key2 = ObjectKey(Animal.self, "your factory")
        XCTAssertNotEqual(key1, key2)
        XCTAssertNotEqual(key1.hashValue, key2.hashValue)

        let key3 = ObjectKey(
            Animal.self,
            "my factory"
        )
        let key4 = ObjectKey(
            Animal.self,
            "your factory"
        )
        XCTAssertNotEqual(key3, key4)
        XCTAssertNotEqual(key3.hashValue, key4.hashValue)
    }
    
    // MARK: With name args
    
    func testObjectKeyEqualsWithTheSameName() {
        let key1 = ObjectKey(Animal.self, "my factory", ObjectContext.self)
        let key2 = ObjectKey(Animal.self, "my factory", ObjectContext.self)
        XCTAssertEqual(key1, key2)
        XCTAssertEqual(key1.hashValue, key2.hashValue)
        
        let key3 = ObjectKey(
            Animal.self,
            "my factory",
            (ObjectContext, String, Bool).self
        )
        let key4 = ObjectKey(
            Animal.self,
            "my factory",
            (ObjectContext, String, Bool).self
        )
        XCTAssertEqual(key3, key4)
        XCTAssertEqual(key3.hashValue, key4.hashValue)
    }
    
    func testObjectKeyDoesNotEqualWithDifferentNames() {
        let key1 = ObjectKey(Animal.self, "my factory", ObjectContext.self)
        let key2 = ObjectKey(Animal.self, "your factory", ObjectContext.self)
        XCTAssertNotEqual(key1, key2)
        XCTAssertNotEqual(key1.hashValue, key2.hashValue)

        let key3 = ObjectKey(
            Animal.self,
            "my factory",
            (ObjectContext, String, Bool).self
        )
        let key4 = ObjectKey(
            Animal.self,
            "your factory",
            (ObjectContext, String, Bool).self
        )
        XCTAssertNotEqual(key3, key4)
        XCTAssertNotEqual(key3.hashValue, key4.hashValue)
    }
}
