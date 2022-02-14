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

@implementation MeModuleDelegate

+ (void)definitionsOfContext:(ObjectContext *)context {
    [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder.cbn_cls(MeViewController);
    } name:@"mevc"];
}

- (void)moduleDidFinishLaunching:(CBNModule *)module_ {
    
}

+ (NSArray<CBNModuleLaunchOptionsItem *> *)launchOptions {
    return @[[CBNModuleLaunchOptionsItem itemWithPriority:CBNModulePriorityBusiness]];
}

@end
