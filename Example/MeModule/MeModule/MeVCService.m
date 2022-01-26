//
//  MeVCService.m
//  MeModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "MeVCService.h"
#import "MeViewController.h"

@implementation MeVCService

- (UIViewController *)meViewController {
    MeViewController *meVC = [[MeViewController alloc] initWithNibName:nil bundle:nil];
    meVC.view.backgroundColor = [UIColor whiteColor];
    meVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Me" image:nil tag:0];
    return meVC;
}

@end
