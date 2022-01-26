//
//  ImageViewFactory.h
//  BasicModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import <Foundation/Foundation.h>
#import "AvatarFactoryProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AvatarFactory : NSObject <AvatarFactoryProtocol>

@property (nonatomic, strong, readonly) UIImageView *lastImageView;
@property (nonatomic, strong, readonly) UILabel *lastLabel;

@end

NS_ASSUME_NONNULL_END
