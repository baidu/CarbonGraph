//
//  ObjectContextPropertyTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
@testable import CarbonCore

class ObjectContextPropertyTests: XCTestCase {
    var context: ApplicationContext!
    
    override func setUpWithError() throws {
        context = ApplicationContext()
    }
    
    func testObjectContextProperty() {
        let builder = Definition()
            .protocol(Car.self)
            .factory { _ in
                Car()
            }
            .propertyName("body")
            .propertyName("brand")
        
        let bodyBuilder = Definition()
            .protocol(Body.self)
            .factory { _ in
                Body()
            }.scope(ObjectScope.prototype)
        
        let brandBuilder = Definition()
            .protocol(Brand.self)
            .factory { _ in
                Brand()
            }
        
        context.register(builder: builder)
        context.register(builder: bodyBuilder)
        context.register(builder: brandBuilder)
        
        let carModel = context[Car.self]
        XCTAssertNotNil(carModel?.body)
        XCTAssertNotNil(carModel?.brand)
    }
    
    func testObjectContextPropertys() {
        let builder = Definition()
            .protocol(Car.self)
            .factory { _ in
                Car()
            }
            .propertiesName(["body", "brand"])
        
        let bodyBuilder = Definition()
            .protocol(Body.self)
            .factory { _ in
                Body()
            }.scope(ObjectScope.prototype)
        
        let brandBuilder = Definition()
            .protocol(Brand.self)
            .factory { _ in
                Brand()
            }
        
        context.register(builder: builder)
        context.register(builder: bodyBuilder)
        context.register(builder: brandBuilder)
        
        let carModel = context[Car.self]
        XCTAssertNotNil(carModel?.body)
        XCTAssertNotNil(carModel?.brand)
    }
}
