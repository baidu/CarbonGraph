//
//  ObjectContextConvenience.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
@testable import CarbonCore

class ObjectContextConvenience: XCTestCase {

    var context: ApplicationContext!
    
    override func setUpWithError() throws {
        context = ApplicationContext()
    }

    override func tearDownWithError() throws {
        context = nil
    }

    func testClassConvenienceRegister() throws {
        context.register(protocol: UITabBarDelegate.self, cls: UITabBarController.self, name: "root").scope(.singleton)
        context.register(protocol: UITabBarDelegate.self, cls: UITabBarController.self).scope(.singleton)
        context.register(cls: UITabBarController.self).scope(.singleton)
        let vc1 = context[UITabBarDelegate.self, name: "root"]
        XCTAssertNotNil(vc1)
        let vc2 = context[UITabBarDelegate.self]
        XCTAssertNotNil(vc2)
        let vc3 = context[UITabBarController.self]
        XCTAssertNotNil(vc3)
        XCTAssertNotIdentical(vc1, vc2)
        XCTAssertNotIdentical(vc2, vc3)
    }
    
    func testObjectConvenienceRegister() throws {
        context.register(protocol: UITabBarDelegate.self, object: UITabBarController(), name: "root").scope(.singleton)
        context.register(protocol: UITabBarDelegate.self, object: UITabBarController()).scope(.singleton)
        context.register(object: UITabBarController()).scope(.singleton)
        let vc1 = context[UITabBarDelegate.self, name: "root"]
        XCTAssertNotNil(vc1)
        let vc2 = context[UITabBarDelegate.self]
        XCTAssertNotNil(vc2)
        let vc3 = context[UITabBarController.self]
        XCTAssertNotNil(vc3)
        XCTAssertNotIdentical(vc1, vc2)
        XCTAssertNotIdentical(vc2, vc3)
    }
    
    
    func testObjCClassConvenienceRegister() throws {
        context.cbn_register(protocol: UITabBarDelegate.self, cls: UITabBarController.self, name: "root").scope(.singleton)
        context.cbn_register(protocol: UITabBarDelegate.self, cls: UITabBarController.self).scope(.singleton)
        context.cbn_register(cls: UITabBarController.self, name: "root").scope(.singleton)
        let vc1 = context[UITabBarDelegate.self, name: "root"]
        XCTAssertNotNil(vc1)
        let vc2 = context[UITabBarDelegate.self]
        XCTAssertNotNil(vc2)
        let vc3 = context[NSObjectProtocol.self, name: "root"]
        XCTAssertNotNil(vc3)
        XCTAssertNotIdentical(vc1, vc2)
        XCTAssertNotIdentical(vc2, vc3)
    }

}
