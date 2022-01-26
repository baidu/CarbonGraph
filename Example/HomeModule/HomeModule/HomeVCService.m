//
//  HomeVCService.m
//  HomeModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "HomeVCService.h"
#import "HomeViewController.h"

@implementation HomeVCService

- (UIViewController *)homeViewController {
    HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:nil bundle:nil];
    homeVC.view.backgroundColor = [UIColor whiteColor];
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
    return homeVC;
}

@end
