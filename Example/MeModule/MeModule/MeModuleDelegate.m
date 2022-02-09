//
//  MeModuleDelegate.m
//  MeModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "MeModuleDelegate.h"
#import "MeViewController.h"
#import "MeVCService.h"

@implementation MeModuleDelegate

+ (void)definitionsOfContext:(ObjectContext *)context {
    [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder.protocol(@protocol(MeVCServiceProtocol))
            .cls(MeVCService.class);
    }];
}

- (void)moduleDidFinishLaunching:(CBNModule *)module_ {
    
}

+ (NSArray<CBNModuleLaunchOptionsItem *> *)launchOptions {
    return @[[CBNModuleLaunchOptionsItem itemWithPriority:CBNModulePriorityBusiness]];
}

@end
