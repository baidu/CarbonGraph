//
//  BasicModuleDelegate.m
//  BasicModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "BasicModuleDelegate.h"
#import "AvatarFactory.h"
#import <BasicModule/BasicModule-Swift.h>

@implementation BasicModuleDelegate

+ (void)definitionsOfContext:(ObjectContext *)context {
    
    // MARK: S1: Protocol defined in ObjC, registered in ObjC, resolved in ObjC
    [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder.cbn_protocol(AvatarFactoryProtocol)
        .cbn_cls(AvatarFactory)
        .singleton();
    }];
    
    id<AvatarFactoryProtocol> factory = CBN_RESOLVE(AvatarFactoryProtocol);
    printf("S1: %s\n", factory.description.UTF8String);

    // MARK: S5: Protocol defined in Swift, registered in ObjC, resolved in ObjC
    [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder.protocol(@protocol(AccountManagerProtocol))
        .cls(AccountManager.class)
        .scope(CBNObjectScope.singleton);
    }];
    id<AccountManagerProtocol> accountManager = CBN_RESOLVE(AccountManagerProtocol);
    printf("S5: %s\n", accountManager.description.UTF8String);
}

- (void)moduleDidFinishLaunching:(CBNModule *)module_ {
    
}

@end


