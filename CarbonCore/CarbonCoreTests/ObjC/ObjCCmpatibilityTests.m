//
//  ObjCCmpatibilityTests.m
//  CarbonCoreTests
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import <XCTest/XCTest.h>
#import "ObjCCmpatibilityFoundation.h"
#import "CarbonCoreTests-Swift.h"

@import CarbonCore;

@interface ObjCCmpatibilityTests : XCTestCase

@property(nonatomic, strong) CBNApplicationContext *context;

@end

@implementation ObjCCmpatibilityTests

- (void)setUp {
    _context = [[CBNApplicationContext alloc] initWithDefaultScope:CBNObjectScope.prototype moduleScan:NO];
}

- (void)tearDown {
    _context = nil;
}

- (void)testExample {
    // 1: Protocol defined in ObjC, registered in ObjC, resolved in ObjC
    [[_context cbn_registerWithProtocol:@protocol(AvatarFactoryProtocol) cls:AvatarFactory.class] scope:CBNObjectScope.singleton];
    id<AvatarFactoryProtocol> factory = (id)_context[@protocol(AvatarFactoryProtocol)];
    XCTAssertNotNil(factory);

    // 3: Protocol defined in ObjC, registered in Swift, resolved in ObjC
    [SwiftExecuteContext registerFileViewControllerTo:_context];
    id<FileViewControllerProtocol> fileViewController = (id)_context[@protocol(FileViewControllerProtocol)];
    XCTAssertNotNil(fileViewController);
    
    // 5: Protocol defined in Swift, registered in ObjC, resolved in ObjC
    [[_context cbn_registerWithProtocol:@protocol(AccountManagerProtocol) cls:AccountManager.class] scope:CBNObjectScope.singleton];
    id<AccountManagerProtocol> accountManager = (id)_context[@protocol(AccountManagerProtocol)];
    XCTAssertNotNil(accountManager);
    
    // 7: Protocol defined in Swift, registered in Swift, resolved in ObjC
    [SwiftExecuteContext registerFileManagerTo:_context];
    id<FileManagerProtocol> fileManager = (id)_context[@protocol(FileManagerProtocol)];
    XCTAssertNotNil(fileManager);
}

@end
