//
//  AvatarFactoryProtocol.h
//  BasicModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AvatarFactoryProtocol <NSObject>

- (UIImageView *)imageViewWithImage:(UIImage *)image;
- (UILabel *)labelWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
