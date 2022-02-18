//
//  ObjCExecuteContext.m
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "ObjCExecuteContext.h"
#import "ObjCCmpatibilityFoundation.h"
#import "CarbonCoreTests-Swift.h"

@implementation ObjCExecuteContext

+ (void)registerAvatarFactoryToContext:(CBNObjectContext *)context {
    [[context cbn_registerWithProtocol:@protocol(AvatarFactoryProtocol) cls:AvatarFactory.class] scope:CBNObjectScope.singleton];
}

+ (void)registerAccountManagerToContext:(CBNObjectContext *)context {
    [[context cbn_registerWithProtocol:@protocol(AccountManagerProtocol) cls:AccountManager.class] scope:CBNObjectScope.singleton];
}

@end
