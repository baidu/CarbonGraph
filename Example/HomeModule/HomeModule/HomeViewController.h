//
//  HomeViewController.h
//  HomeModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import <UIKit/UIKit.h>
@import FileModule;

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController

@property (nonatomic, strong) id<FileManagerProtocol> fileManager;

@end

NS_ASSUME_NONNULL_END
