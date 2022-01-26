//
//  MeViewController.m
//  MeModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "MeViewController.h"
#import <BasicModule/BasicModule-umbrella.h>
@import CarbonObjC;

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect bounds = self.view.bounds;
    
    id<AvatarFactoryProtocol> factory = CBN_RESOLVE(AvatarFactoryProtocol);
    
    UIImageView *iconImageView = [factory imageViewWithImage:[UIImage imageNamed:@"carbon_about_icon"]];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    iconImageView.frame = CGRectMake(bounds.size.width / 2 - 50, 100, 100, 100);
    [self.view addSubview:iconImageView];
    
    UIImageView *carbonImageView = [factory imageViewWithImage:[UIImage imageNamed:@"carbon_about"]];
    carbonImageView.contentMode = UIViewContentModeScaleAspectFit;
    carbonImageView.frame = CGRectMake(bounds.size.width / 2 - 110, 200, 225, 65);
    [self.view addSubview:carbonImageView];
    
    UILabel *label = [factory labelWithString:@"CarbonGraph is a Swift dependency injection / lookup framework for iOS. You can use it to build loose coupling between modules."];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 10;
    label.frame = CGRectMake(bounds.size.width / 2 - 150, 200, 300, 300);
    [self.view addSubview: label];
    
    // MARK: S3: Protocol defined in ObjC, registered in Swift, resolved in ObjC
    id<FileViewControllerProtocol> fileViewController = (id)Application.sharedApplication.context[@protocol(FileViewControllerProtocol)];
    printf("S3: %s\n", fileViewController.description.UTF8String);
}


@end
