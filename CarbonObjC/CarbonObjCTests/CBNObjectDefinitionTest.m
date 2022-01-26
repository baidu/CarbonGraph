//
//  CBNObjectDefinitionTest.m
//  CarbonObjCTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "CBNObjectDefinitionTest.h"
#import "OCProtocol.h"
#import "CarbonObjCTests-Swift.h"
#import "CBNComputer.h"
#import <CarbonObjC/CBNObjectDefinition.h>

@import CarbonCore;

@interface CBNObjectDefinitionTest ()

@property(nonatomic, strong) CBNApplicationContext *context;

@property (nonatomic, strong) CBNWrapperCPU *wrappercpu;

@end
@implementation CBNObjectDefinitionTest

- (void)setUp {
    _context = [[CBNApplicationContext alloc] initWithDefaultScope:CBNObjectScope.prototype moduleScan:NO];
}

- (void)tearDown {
    _context = nil;
}

- (void)testObjectContextResolveOCProtocol {
    
    DefinitionBuilder *builder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
        .protocol(@protocol(OCProtocol))
        .cls(PetOwner.class)
        .scope(CBNObjectScope.singleton);
    }];
    [_context registerWithBuilder:builder];
    
    id<OCProtocol> object = (id)_context[@protocol(OCProtocol)];
    XCTAssertTrue([object isKindOfClass:[PetOwner class]]);
    
    Class class = [_context objectClass:@protocol(OCProtocol)];
    XCTAssertTrue(class == [PetOwner class]);
    
    id objectBySubscript = _context[@protocol(OCProtocol)];
    XCTAssertTrue([objectBySubscript isKindOfClass:[PetOwner class]]);
}

- (void)testObjectContextResolveAlias {

    DefinitionBuilder *builder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
        .protocol(@protocol(OCProtocol))
        .aliasProtocol(@protocol(OCAliasProtocol))
        .aliasProtocol(@protocol(OCAliasOtherProtocol))
        .cls(PetOwner.class)
        .scope(CBNObjectScope.singleton);
    }];
    [_context registerWithBuilder:builder];

    id<OCAliasProtocol> object1 = (id)_context[@protocol(OCAliasProtocol)];
    id<OCAliasProtocol> object2 = (id)_context[@protocol(OCAliasOtherProtocol)];
    XCTAssertTrue([object1 isKindOfClass:[PetOwner class]]);
    XCTAssertTrue([object2 isKindOfClass:[PetOwner class]]);
}

- (void)testObjectContextResolveAliasArray {
    DefinitionBuilder *builder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
        .protocol(@protocol(OCProtocol))
        .alias(@[@protocol(OCAliasProtocol)])
        .cls(PetOwner.class);
    }];
    
    [_context registerWithBuilder:builder];
    
    id<OCAliasProtocol> object = (id)_context[@protocol(OCAliasProtocol)];
    XCTAssertTrue([object isKindOfClass:[PetOwner class]]);
}

- (void)testObjectContextResolveOCFactory {
 
    DefinitionBuilder *builder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
        .protocol(@protocol(OCProtocol))
        .alias(@[@protocol(OCAliasProtocol)])
        .factory(^NSObject *(CBNObjectContext *ctx) {
            return [[PetOwner alloc] init];
        });
        
    }];
    [_context registerWithBuilder:builder];
    
    id<OCAliasProtocol> object = (id)_context[@protocol(OCAliasProtocol)];
    XCTAssertTrue([object isKindOfClass:[PetOwner class]]);
}

- (void)testObjectContextResolveOCFactoryWithAction {
 
    DefinitionBuilder *builder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
        .protocol(@protocol(OCProtocol))
        .alias(@[@protocol(OCAliasProtocol)])
        .factory(^NSObject *(CBNObjectContext *ctx) {
            return [[PetOwner alloc] init];
        })
        .cls(PetOwner.class)
        .scope(CBNObjectScope.prototype)
        .completed(^void(CBNObjectContext *ctx, NSObject *obj){
            NSLog(@"Carbon resolve completed scop 1: %@", obj);
        })
        .completed(^void(CBNObjectContext *ctx, NSObject *obj){
            NSLog(@"Carbon resolve completed scop 2: %@", obj);
        });
        
    }];
    [_context registerWithBuilder:builder];
    
    id<OCAliasProtocol> object = (id)_context[@protocol(OCAliasProtocol)];
    XCTAssertTrue([object isKindOfClass:[PetOwner class]]);
}

- (void)testObjectContextResolveAliasHandlyCategory {
    DefinitionBuilder *builder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
            .cbn_protocol(OCProtocol)
            .cbn_aliasProtocol(OCAliasProtocol)
            .cbn_aliasProtocol(OCAliasOtherProtocol)
            .cbn_cls(PetOwner)
            .scope(CBNObjectScope.singleton);
    }];
    [_context registerWithBuilder:builder];
    
    id<OCAliasProtocol> object1 = (id)_context[@protocol(OCAliasProtocol)];
    id<OCAliasProtocol> object2 = (id)_context[@protocol(OCAliasOtherProtocol)];
    XCTAssertTrue([object1 isKindOfClass:[PetOwner class]]);
    XCTAssertTrue([object2 isKindOfClass:[PetOwner class]]);
    
    {
        DefinitionBuilder *builder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
            builder
                .cbn_protocol(OCProtocol)
                .cbn_alias(OCAliasProtocol)
                .cbn_cls(PetOwner)
                .scope(CBNObjectScope.singleton);
        }];
        [_context registerWithBuilder:builder];
        
        id<OCAliasProtocol> object1 = (id)_context[@protocol(OCAliasProtocol)];
        id<OCAliasProtocol> object2 = (id)_context[@protocol(OCAliasOtherProtocol)];
        XCTAssertTrue([object1 isKindOfClass:[PetOwner class]]);
        XCTAssertTrue([object2 isKindOfClass:[PetOwner class]]);
    }
    
    {
        DefinitionBuilder *builder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
            builder
                .cbn_protocol(OCProtocol)
                .cbn_alias2(OCAliasProtocol, OCAliasOtherProtocol)
                .cbn_cls(PetOwner)
                .scope(CBNObjectScope.singleton);
        }];
        [_context registerWithBuilder:builder];
        
        id<OCAliasProtocol> object1 = (id)_context[@protocol(OCAliasProtocol)];
        id<OCAliasProtocol> object2 = (id)_context[@protocol(OCAliasOtherProtocol)];
        XCTAssertTrue([object1 isKindOfClass:[PetOwner class]]);
        XCTAssertTrue([object2 isKindOfClass:[PetOwner class]]);
    }
    {
        DefinitionBuilder *builder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
            builder
                .cbn_protocol(OCProtocol)
                .cbn_alias3(OCAliasProtocol, OCAliasOtherProtocol, OCAliasOtherProtocol1)
                .cbn_cls(PetOwner)
                .scope(CBNObjectScope.singleton);
        }];
        [_context registerWithBuilder:builder];
        
        id<OCAliasProtocol> object1 = (id)_context[@protocol(OCAliasProtocol)];
        id<OCAliasProtocol> object2 = (id)_context[@protocol(OCAliasOtherProtocol)];
        id<OCAliasProtocol> object3 = (id)_context[@protocol(OCAliasOtherProtocol1)];
        XCTAssertTrue([object1 isKindOfClass:[PetOwner class]]);
        XCTAssertTrue([object2 isKindOfClass:[PetOwner class]]);
        XCTAssertTrue([object3 isKindOfClass:[PetOwner class]]);
    }
    
    {
        DefinitionBuilder *builder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
            builder
                .cbn_protocol(OCProtocol)
                .cbn_alias4(OCAliasProtocol, OCAliasOtherProtocol, OCAliasOtherProtocol1, OCAliasOtherProtocol2)
                .cbn_cls(PetOwner)
                .scope(CBNObjectScope.singleton);
        }];
        [_context registerWithBuilder:builder];
        
        id<OCAliasProtocol> object1 = (id)_context[@protocol(OCAliasProtocol)];
        id<OCAliasProtocol> object2 = (id)_context[@protocol(OCAliasOtherProtocol)];
        id<OCAliasProtocol> object3 = (id)_context[@protocol(OCAliasOtherProtocol1)];
        id<OCAliasProtocol> object4 = (id)_context[@protocol(OCAliasOtherProtocol2)];
        XCTAssertTrue([object1 isKindOfClass:[PetOwner class]]);
        XCTAssertTrue([object2 isKindOfClass:[PetOwner class]]);
        XCTAssertTrue([object3 isKindOfClass:[PetOwner class]]);
        XCTAssertTrue([object4 isKindOfClass:[PetOwner class]]);
    }
    
    {
        DefinitionBuilder *builder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
            builder
                .cbn_protocol(OCProtocol)
                .cbn_alias5(OCAliasProtocol, OCAliasOtherProtocol, OCAliasOtherProtocol1, OCAliasOtherProtocol2, OCAliasOtherProtocol3)
                .cbn_cls(PetOwner)
                .scope(CBNObjectScope.singleton);
        }];
        [_context registerWithBuilder:builder];
        
        id<OCAliasProtocol> object1 = (id)_context[@protocol(OCAliasProtocol)];
        id<OCAliasProtocol> object2 = (id)_context[@protocol(OCAliasOtherProtocol)];
        id<OCAliasProtocol> object3 = (id)_context[@protocol(OCAliasOtherProtocol1)];
        id<OCAliasProtocol> object4 = (id)_context[@protocol(OCAliasOtherProtocol2)];
        id<OCAliasProtocol> object5 = (id)_context[@protocol(OCAliasOtherProtocol3)];
        XCTAssertTrue([object1 isKindOfClass:[PetOwner class]]);
        XCTAssertTrue([object2 isKindOfClass:[PetOwner class]]);
        XCTAssertTrue([object3 isKindOfClass:[PetOwner class]]);
        XCTAssertTrue([object4 isKindOfClass:[PetOwner class]]);
        XCTAssertTrue([object5 isKindOfClass:[PetOwner class]]);
    }
    
}

- (void)testObjcContenxtResolveProperties {
    DefinitionBuilder *cpuBuilder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
        .protocol(@protocol(CPU))
        .cls(Intel.class);
    }];
    
    DefinitionBuilder *osBuilder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
        .protocol(@protocol(OS))
        .cls(MacOS.class);
    }];
    
    DefinitionBuilder *macBuilder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
        .protocol(@protocol(ComputerProtocol))
        .cls(Mac.class)
        .propertyName(@"os") // will be covered by propertiesName
        .propertiesName(@[@"cpu", @"os"]);
    }];
    [_context registerWithBuilder:cpuBuilder];
    [_context registerWithBuilder:osBuilder];
    [_context registerWithBuilder:macBuilder];
    

    id<ComputerProtocol>computer = (id)_context[@protocol(ComputerProtocol)];
    XCTAssertNotNil(computer);
    XCTAssertNotNil(computer.cpu);
    XCTAssertNotNil(computer.os);
    
}

- (void)testObjecInValidParams {
    DefinitionBuilder *cpuBuilder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
        .protocol(@protocol(CPU))
        //.factory(nil)
        .cls(Intel.class);
    }];
    
    DefinitionBuilder *osBuilder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
        .protocol(@protocol(OS))
        .factory(^NSObject *(CBNObjectContext *ctx) {
            return nil;
        });
    }];
    
    DefinitionBuilder *macBuilder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
        .protocol(@protocol(ComputerProtocol))
        .cls(Mac.class)
        .propertyName(@"cpu")
        .propertyName(@"")
        .propertyName(@"HasNotThisProprty");
    }];
    [_context registerWithBuilder:cpuBuilder];
    [_context registerWithBuilder:osBuilder];
    [_context registerWithBuilder:macBuilder];
    
    id<ComputerProtocol>computer = (id)_context[@protocol(ComputerProtocol)];
    XCTAssertNotNil(computer);
    XCTAssertNotNil(computer.cpu);
    XCTAssertNil(computer.os);
    
}

- (void)testDefineObjectScopeWithProperties {
    
    DefinitionBuilder *cpuIntelBuilder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder.cbn_protocol(CPU)
            .cbn_cls(Intel)
            .singleton();
    }];
    
    [_context registerWithBuilder:cpuIntelBuilder];
    id<CPU>cpuI1 = (id)_context[@protocol(CPU)];
    id<CPU>cpuI2 = (id)_context[@protocol(CPU)];
    id<CPU>cpuI3 = (id)_context[@protocol(CPU)];
    XCTAssertEqual(cpuI1, cpuI2);
    XCTAssertEqual(cpuI3, cpuI2);
    
    DefinitionBuilder *cpuAmdBuilder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder.cbn_protocol(CPU)
            .cbn_cls(Intel)
            .prototype();
    }];
    
    [_context registerWithBuilder:cpuAmdBuilder];
    id<CPU>cpuA1 = (id)_context[@protocol(CPU)];
    id<CPU>cpuA2 = (id)_context[@protocol(CPU)];
    id<CPU>cpuA3 = (id)_context[@protocol(CPU)];
    XCTAssertNotEqual(cpuA1, cpuA2);
    XCTAssertNotEqual(cpuA3, cpuA2);
}

- (void)testDefineObjectSingletonWeakScopeWithProperties {
    DefinitionBuilder *cpuIntelBuilder = [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder.cbn_protocol(CPU)
            .cbn_cls(Intel)
            .singletonWeak();
    }];
    
    [_context registerWithBuilder:cpuIntelBuilder];
    
    NSString *temp = [self tempDescription];
    NSString *hold = [self holdDescription];
    id<CPU>cpu = (id)_context[@protocol(CPU)];
    NSString *str = cpu.description;

    XCTAssertFalse([temp isEqualToString:hold]);
    XCTAssertTrue([hold isEqualToString:str]);
}

- (NSString *)tempDescription {
    id<CPU>cpu = (id)_context[@protocol(CPU)];
    CBNWrapperCPU *obj = [[CBNWrapperCPU alloc] init];
    obj.cpu = cpu;
    return cpu.description;
}

- (NSString *)holdDescription {
    id<CPU>cpu = (id)_context[@protocol(CPU)];
    self.wrappercpu = [[CBNWrapperCPU alloc] init];
    self.wrappercpu.cpu = cpu;
    return cpu.description;
}

@end
