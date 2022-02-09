//
//  ObjectContextTestsOC.m
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import <XCTest/XCTest.h>
#import "OCProtocol.h"
#import "CarbonCoreTests-Swift.h"
#import "CBNComputer.h"

@import CarbonCore;

@interface ObjectContextTestsOC : XCTestCase

@property(nonatomic, strong) CBNApplicationContext *context;

@end

@implementation ObjectContextTestsOC

- (void)setUp {
    _context = [[CBNApplicationContext alloc] initWithDefaultScope:CBNObjectScope.prototype moduleScan:NO];
}

- (void)tearDown {
    _context = nil;
}

- (void)testObjectContextResolveOCProtocol {
    DefinitionBuilder *builder = [[[[KeyDefinitionBuilder new]
                                    protocol:@protocol(OCProtocol)]
                                   cls:PetOwner.class]
                                  scope:CBNObjectScope.singleton];
    [_context registerWithBuilder:builder];
    
    id<OCProtocol> object = (id)_context[@protocol(OCProtocol)];
    XCTAssertTrue([object isKindOfClass:[PetOwner class]]);
    
    Class class = [_context objectClass:@protocol(OCProtocol)];
    XCTAssertTrue(class == [PetOwner class]);
    
    id objectBySubscript = _context[@protocol(OCProtocol)];
    XCTAssertTrue([objectBySubscript isKindOfClass:[PetOwner class]]);
}

- (void)testObjectContextResolveOCProtocolWithName {
    KeyDefinitionBuilder *keyBuilder = [[KeyDefinitionBuilder alloc]
                                        initWithName:@"a"];
    DefinitionBuilder *builder = [[keyBuilder protocol:@protocol(OCProtocol)]
                                  cls:PetOwner.class];
    [_context registerWithBuilder:builder];
    
    id<OCProtocol> object = (id<OCProtocol>)_context[@protocol(OCProtocol)];
    XCTAssertFalse([object isKindOfClass:[PetOwner class]]);
    id<OCProtocol> object2 = (id<OCProtocol>)[_context objectWithProtocol:@protocol(OCProtocol) name:@"a"];
    XCTAssertTrue([object2 isKindOfClass:[PetOwner class]]);
}

- (void)testObjectContextResolveOCFactory {
    DefinitionBuilder *builder = [[[[KeyDefinitionBuilder new]
                                    protocol:@protocol(OCProtocol)]
                                   alias:@[@protocol(OCAliasProtocol)]]
                                  factory:^NSObject * _Nonnull(CBNObjectContext * _Nonnull context) {
        return [[PetOwner alloc] init];
    }];
    
    [_context registerWithBuilder:builder];
    
    id<OCAliasProtocol> object = (id)_context[@protocol(OCAliasProtocol)];
    XCTAssertTrue([object isKindOfClass:[PetOwner class]]);
}

- (void)testObjectContextResolveAlias {
    DefinitionBuilder *builder = [[[[[KeyDefinitionBuilder new]
                                     protocol:@protocol(OCProtocol)]
                                    aliasProtocol:@protocol(OCAliasProtocol)]
                                   aliasProtocol:@protocol(OCAliasOtherProtocol)]
                                  cls:PetOwner.class];
    [_context registerWithBuilder:builder];
    
    id<OCAliasProtocol> object1 = (id)_context[@protocol(OCAliasProtocol)];
    id<OCAliasProtocol> object2 = (id)_context[@protocol(OCAliasOtherProtocol)];
    XCTAssertTrue([object1 isKindOfClass:[PetOwner class]]);
    XCTAssertTrue([object2 isKindOfClass:[PetOwner class]]);
}

- (void)testObjectContextResolveAliasArray {
    DefinitionBuilder *builder = [[[[KeyDefinitionBuilder new]
                                    protocol:@protocol(OCProtocol)]
                                   alias:@[@protocol(OCAliasProtocol)]]
                                  cls:PetOwner.class];
    
    [_context registerWithBuilder:builder];
    
    id<OCAliasProtocol> object = (id)_context[@protocol(OCAliasProtocol)];
    XCTAssertTrue([object isKindOfClass:[PetOwner class]]);
}

- (void)testObjcResolveProperties {
    
    DefinitionBuilder *builder = [[[KeyDefinitionBuilder new]
                                    protocol:@protocol(CPU)]
                                  cls:Intel.class];
    [_context registerWithBuilder:builder];
    
    {
        DefinitionBuilder *builder = [[[KeyDefinitionBuilder new]
                                        protocol:@protocol(OS)]
                                      cls:MacOS.class];
        [_context registerWithBuilder:builder];
    }
    
    {
        DefinitionBuilder *builder = [[[[KeyDefinitionBuilder new]
                                         protocol:@protocol(ComputerProtocol)]
                                        cls:Mac.class]
                                      propertiesName:@[@"os", @"cpu"]];
        [_context registerWithBuilder:builder];
    }
    
    id<ComputerProtocol> computer = (id)_context[@protocol(ComputerProtocol)];
    XCTAssertTrue([computer isKindOfClass:[Mac class]]);
    XCTAssertTrue([computer.cpu isKindOfClass:[Intel class]]);
    XCTAssertTrue([computer.os isKindOfClass:[MacOS class]]);
    
}

- (void)testConvenienceRegister {
    [_context cbn_registerWithProtocol:@protocol(UITabBarDelegate) cls:UITabBarController.class name:@"root"];
    [_context cbn_registerWithProtocol:@protocol(UITabBarDelegate) cls:UITabBarController.class];
    [_context cbn_registerWithCls:UITabBarController.class name:@"root"];
    id vc1 = [_context objectWithProtocol:@protocol(UITabBarDelegate) name:@"root"];
    XCTAssertNotNil(vc1);
    id vc2 = _context[@protocol(UITabBarDelegate)];
    XCTAssertNotNil(vc2);
    id vc3 = [_context objectWithProtocol:@protocol(NSObject) name:@"root"];
    XCTAssertNotNil(vc3);
    XCTAssertNotIdentical(vc1, vc2);
    XCTAssertNotIdentical(vc2, vc3);
}

@end
