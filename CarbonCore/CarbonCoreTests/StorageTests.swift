//
//  StorageTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import Foundation
import XCTest
@testable import CarbonCore

class StorageTests: XCTestCase {
    
    // MARK: WeakStorage
    // MARK: Storing reference type
    
    func testWeakStorageShouldProvideStoredInstanceWithStrongReference() {
        let object = DummyObject()
        let storage = WeakStorage()
        storage.object = object
        XCTAssert(storage.object as? DummyObject === object)
    }

    func testWeakStorageShouldNotPersistInstanceWithoutStrongReference() {
        let storage = WeakStorage()
        storage.object = DummyObject()
        XCTAssertNil(storage.object)
    }

    func testWeakStorageShouldNotPersistInstanceWithWeakReference() {
        var object: DummyObject? = DummyObject()
        weak var weakObject = object
        let storage = WeakStorage()
        storage.object = object

        object = nil

        XCTAssertNil(storage.object)
        XCTAssertNil(weakObject)
    }

    // MARK: Storing value type
    
    func testWeakStorageShouldNotPersistInstance() {
        let value = DummyStruct()
        let storage = WeakStorage()
        storage.object = value
        XCTAssertNil(storage.object)
    }
}

private struct DummyStruct {}
private class DummyObject {}
