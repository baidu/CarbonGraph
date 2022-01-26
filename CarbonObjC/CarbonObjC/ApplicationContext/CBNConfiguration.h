//
//  CBNConfiguration.h
//  CarbonObjC
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import <Foundation/Foundation.h>
@class ObjectContext;

NS_ASSUME_NONNULL_BEGIN

@protocol CBNConfiguration <NSObject>

+ (void)definitionsOfContext:(ObjectContext *)context;

@end

NS_ASSUME_NONNULL_END
