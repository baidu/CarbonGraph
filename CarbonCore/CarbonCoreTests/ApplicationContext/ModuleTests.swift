//
//  ModuleTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
@testable import CarbonCore

class ModuleTests: XCTestCase {
    
    func testModulePriority() throws {
        class TestModuleDelegate: ModuleDelegate {
            required init() {}
        }
        
        let module1 = Module(launchOptions: ModuleLaunchOptions(
            delegateClass: TestModuleDelegate.self,
            items: [.lazyLoad(true), .priority(.business)]
        ))
        
        let module2 = Module(launchOptions: ModuleLaunchOptions(
            delegateClass: TestModuleDelegate.self,
            items: [.lazyLoad(false), .priority(.cbn.services.increase(999))]
        ))
                             
        let module3 = Module(launchOptions: ModuleLaunchOptions(
            delegateClass: TestModuleDelegate.self,
            items: [.lazyLoad(false), .priority(.foundation)]
        ))
                             
        let module4 = Module(launchOptions: ModuleLaunchOptions(
            delegateClass: TestModuleDelegate.self,
            items: [.lazyLoad(true), .priority(.system)]
        ))
                             
        let modules = [module1, module4, module2, module3].sorted {
            $0.comparePriority(to: $1) == .orderedDescending
        }
        XCTAssertEqual(modules[0], module3)
        XCTAssertEqual(modules[1], module2)
        XCTAssertEqual(modules[2], module4)
        XCTAssertEqual(modules[3], module1)
    }

}
