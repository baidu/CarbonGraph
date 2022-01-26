//
//  ObjectContextStructTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
@testable import CarbonCore

class ObjectContextStructTests: XCTestCase {

    var context: ApplicationContext!
    
    override func setUpWithError() throws {
        context = ApplicationContext()
    }

    override func tearDownWithError() throws {
        context = nil
    }

    func testStructResolving() throws {
        let builder = Definition()
            .protocol(AnimalKeeper.self)
            .object(DogKeeper(animal: Dog(name: "Rocky")))
        context.register(builder: builder)
        let keeper = context[AnimalKeeper.self]!
        XCTAssertTrue(type(of: keeper) == DogKeeper.self)
        let keeperType = context.objectType(AnimalKeeper.self)
        XCTAssertTrue(keeperType == DogKeeper.self)
        if let type = keeperType as? AnimalKeeper.Type {
            XCTAssertEqual(type.forbiddenBreed(), ["Bernese Mountain"])
        }
    }

    func testStructConstructorInjection() throws {
        let builder = Definition()
            .protocol(AnimalKeeper.self)
            .constructor(CatKeeper.init(animal:))
        let builder2 = Definition()
            .protocol(Animal.self)
            .object(Cat(name: "Lucky"))
        context.register(builder: builder)
        context.register(builder: builder2)
        let keeper = context[AnimalKeeper.self]!
        XCTAssertTrue(type(of: keeper) == CatKeeper.self)
        XCTAssertTrue(type(of: keeper.animal) == Cat.self)
    }
    
}
