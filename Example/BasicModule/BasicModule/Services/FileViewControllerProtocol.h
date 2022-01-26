//
//  FileViewControllerProtocol.h
//  BasicModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import <Foundation/Foundation.h>

@protocol FileModelProtocol;

NS_ASSUME_NONNULL_BEGIN

@protocol FileViewControllerProtocol <NSObject>

@property (nonatomic, strong) id<FileModelProtocol> rootFileModel;

@end

NS_ASSUME_NONNULL_END
