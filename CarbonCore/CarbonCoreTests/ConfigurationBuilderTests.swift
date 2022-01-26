//
//  ConfigurationBuilderTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
@testable import CarbonCore

protocol UIViewControllerProtocol {
    var view: UIView! { get set }
}

extension UIViewController: UIViewControllerProtocol {}

class ConfigurationBuilderTests: XCTestCase {
    
    let context = ApplicationContext()
    static var completCount = 0
    
    class ModuleDelegate: ScannableModuleConfiguration {
        static func definitions(of context: ObjectContext) -> Definitions {
            GroupDefinitions {
                Definition("root").object(UITabBarController())
                Definition().object(UINavigationController())
                Definition("split").object(UISplitViewController())
            }
            .name("nav")
            .alias([UIViewController.self, UIViewControllerProtocol.self])
            .scope(.default)
            .completed { _, obj in
                completCount += 1
            }
            
            for i in 0..<3 {
                Definition("guidevc\(i)")
                    .protocol(UIViewControllerProtocol.self)
                    .object(UIViewController())
            }
            
            if true {
                Definition().object(UITabBarController())
                Definition().object(UINavigationController())
            }
            
            if "".count == 10 {} else {
                Definition().object(UISplitViewController())
            }
        }
    }

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        context.clean()
        ConfigurationBuilderTests.completCount = 0
    }

    func testDSL() throws {
        context.register(configuration: ModuleDelegate.self)
        XCTAssertEqual(context.objects.count, 15)
        
        let a = context[UITabBarController.self, name: "root"]
        XCTAssertNotNil(a)
        
        let b = context[UINavigationController.self, name: "nav"]
        XCTAssertNotNil(b)
        
        let c = context[UISplitViewController.self, name: "split"]
        XCTAssertNotNil(c)
        
        let d = context[UIViewController.self, name: "root"]
        XCTAssertNotNil(d)
        
        let e = context[UIViewControllerProtocol.self, name: "nav"]
        XCTAssertNotNil(e)
        
        let f = context[UIViewControllerProtocol.self, name: "split"]
        XCTAssertNotNil(f)
        
        let g = context[UIViewControllerProtocol.self, name: "guidevc0"]
        XCTAssertNotNil(g)
        
        let h = context[UIViewControllerProtocol.self, name: "guidevc1"]
        XCTAssertNotNil(h)
        
        let i = context[UIViewControllerProtocol.self, name: "guidevc2"]
        XCTAssertNotNil(i)
        
        let j = context[UITabBarController.self]
        XCTAssertNotNil(j)
        
        let k = context[UINavigationController.self]
        XCTAssertNotNil(k)
        
        let l = context[UISplitViewController.self]
        XCTAssertNotNil(l)
        
        XCTAssertEqual(ConfigurationBuilderTests.completCount, 6)
    }

}
