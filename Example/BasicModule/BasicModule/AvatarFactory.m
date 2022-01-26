//
//  ImageViewFactory.m
//  BasicModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "AvatarFactory.h"
@import CarbonObjC;

@interface AvatarFactory ()

@property (nonatomic, strong) UIImageView *lastImageView;
@property (nonatomic, strong) UILabel *lastLabel;

@end

@implementation AvatarFactory

+ (instancetype)sharedInstance {
    return CBN_RESOLVE(AvatarFactoryProtocol);
}

- (UIImageView *)imageViewWithImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.image = image;
    self.lastImageView = imageView;
    return imageView;
}

- (UILabel *)labelWithString:(NSString *)string {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = string;
    self.lastLabel = label;
    return label;
}

@end
