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
@import FileModule;

@implementation HomeModuleDelegate

+ (void)definitionsOfContext:(ObjectContext *)context {
    [CBNObjectDefinition define:^(CBNKeyDefinitionBuilder * _Nonnull builder) {
        builder
            .cbn_cls(HomeViewController)
            .propertyName(CBN_PROPERTY(HomeViewController, fileManager));
    } name:@"homevc"];
}

- (void)moduleDidFinishLaunching:(CBNModule *)module_ {
    
}

+ (NSArray<CBNModuleLaunchOptionsItem *> *)launchOptions {
    return @[[CBNModuleLaunchOptionsItem itemWithPriority:CBNModulePriorityBusiness + 1]];
}

@end
