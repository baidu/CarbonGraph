//
//  CBNScannableObject.h
//  CarbonObjC
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import <Foundation/Foundation.h>
#import "CBNConfiguration.h"
@import CarbonCore;

NS_ASSUME_NONNULL_BEGIN

@interface CBNScannableObject : NSObject

@end

#define CBNScannableConfiguration CBNScannableObject<CBNConfiguration>
#define CBNScannableModuleConfiguration CBNScannableObject<CBNModuleDelegate,CBNConfiguration>

NS_ASSUME_NONNULL_END
