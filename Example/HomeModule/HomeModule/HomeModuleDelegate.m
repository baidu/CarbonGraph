//
//  HomeModuleDelegate.m
//  HomeModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "HomeModuleDelegate.h"
#import "HomeViewController.h"
#import "HomeVCService.h"

@implementation HomeModuleDelegate

+ (void)definitionsOfContext:(ObjectContext *)context {
    [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder.protocol(@protocol(HomeVCServiceProtocol))
            .cls(HomeVCService.class);
    }];
}

- (void)moduleDidFinishLaunching:(CBNModule *)module_ {
    
}

@end
