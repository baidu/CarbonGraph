//
//  ObjCCmpatibilityTests.h
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AvatarFactoryProtocol <NSObject> @end

@interface AvatarFactory : NSObject <AvatarFactoryProtocol> @end

@protocol FileViewControllerProtocol <NSObject>
@property (nonatomic, strong, nullable) id<AvatarFactoryProtocol> avatarFactory;
@end

NS_ASSUME_NONNULL_END
