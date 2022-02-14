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
#import <BasicModule/BasicModule-Swift.h>

@implementation BasicModuleDelegate

+ (void)definitionsOfContext:(ObjectContext *)context {
    [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder.cbn_protocol(AccountManagerProtocol)
        .cbn_cls(AccountManager)
        .scope(CBNObjectScope.singleton);
    }];
}

- (void)moduleDidFinishLaunching:(CBNModule *)module_ {
    
}

@end


