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

@implementation MeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Me";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    id<AccountManagerProtocol> accountManager = CBN_RESOLVE(AccountManagerProtocol);
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:accountManager.accountInfo.avatarImage];
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    iconImageView.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 2 - 150, 50, 300, 300);
    [self.view addSubview:iconImageView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = accountManager.accountInfo.name;
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 10;
    label.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 2 - 150, 200, 300, 300);
    [self.view addSubview: label];
}


@end
