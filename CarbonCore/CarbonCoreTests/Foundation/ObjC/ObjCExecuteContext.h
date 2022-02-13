//
//  ObjCExecuteContext.h
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import <Foundation/Foundation.h>
@import CarbonCore;

NS_ASSUME_NONNULL_BEGIN

@interface ObjCExecuteContext : NSObject

+ (void)registerAvatarFactoryToContext:(CBNObjectContext *)context;
+ (void)registerAccountManagerToContext:(CBNObjectContext *)context;

@end

NS_ASSUME_NONNULL_END
