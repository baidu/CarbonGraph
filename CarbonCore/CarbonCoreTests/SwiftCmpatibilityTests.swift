//
//  SwiftCmpatibility.swift
//  CarbonCoreTests
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
import CarbonCore

class SwiftCmpatibilityTests: XCTestCase {

    var context: ApplicationContext!
    
    override func setUpWithError() throws {
        context = ApplicationContext()
    }

    override func tearDownWithError() throws {
        context = nil
    }

    func testExample() throws {
        // 2: Protocol defined in ObjC, registered in ObjC, resolved in Swift
        ObjCExecuteContext.registerAvatarFactory(to: context)
        let avatarFactory = context[AvatarFactoryProtocol.self]
        XCTAssertNotNil(avatarFactory)
        
        // 4: Protocol defined in ObjC, registered in Swift, resolved in Swift
        SwiftExecuteContext.registerFileViewController(to: context)
        let fileVC = context[FileViewControllerProtocol.self]
        XCTAssertNotNil(fileVC)
        XCTAssertNotNil(fileVC?.avatarFactory)
        
        // 6: Protocol defined in Swift, registered in ObjC, resolved in Swift
        ObjCExecuteContext.registerAccountManager(to: context)
        let accountManager = context[AccountManagerProtocol.self]
        XCTAssertNotNil(accountManager)
        
        // 8: Protocol defined in Swift, registered in Swift, resolved in Swift
        let def1 = Definition()
            .protocol(FileModelProtocol.self)
            .constructor(FileModel.init(filePath1:))
        let def2 = Definition().object(FilePath(path: "/root/"))
        context.register(builder: def1)
        context.register(builder: def2)
        if let fileModel = context[FileModelProtocol.self] {
            XCTAssertNotNil(fileModel)
            XCTAssertEqual(fileModel.filePath1, "/root/")
        }
        
        let def3 = Definition()
            .factory(SwiftCmpatibilityTests.fileModel(context:arg1:arg2:))
        context.register(builder: def3)
        if let fileModel = context[FileModelProtocol.self, "/a/b/", "c.mp4"] {
            XCTAssertNotNil(fileModel)
            XCTAssertEqual(fileModel.filePath1, "/a/b/")
            XCTAssertEqual(fileModel.filePath2, "c.mp4")
        }
    }

}


extension SwiftCmpatibilityTests {
    static func fileModel(context: ObjectContext, arg1: String, arg2: String) -> FileModelProtocol {
        FileModel(filePath1: FilePath(path: arg1),
                  filePath2: FilePath(path: arg2))
    }
}
