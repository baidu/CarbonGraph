//
//  CBNApplication.m
//  CarbonObjC
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "CBNApplication.h"
#import "CBNScannableObjectStrategy.h"
#import "CBNConfiguration.h"
@import CarbonCore;

@implementation CBNApplication

+ (CBNApplicationContext *)makeApplicationContext {
    id<CBNScannableStrategy> objcStrategy = [[CBNScannableObjectStrategy alloc] init];
    id<CBNScannableStrategy> swiftStrategy = [[ScannableObjectStrategy alloc] init];
    return [[CBNApplicationContext alloc] initWithDefaultScope:CBNObjectScope.default_ strategies:@[objcStrategy, swiftStrategy]];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        CBNScannableObjectStrategy *strategy = [[CBNScannableObjectStrategy alloc] init];
        for (Class cls in self.context.scannedClasses) {
            if ([strategy isMatchedWithAnyClass:cls]) {
                if ([cls respondsToSelector:@selector(definitionsOfContext:)]) {
                    [cls definitionsOfContext:(ObjectContext *)self.context];
                }
            }
        }
    }
    return self;
}

@end
