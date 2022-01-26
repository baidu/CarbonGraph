//
//  CBNScannableObjectStrategy.m
//  CarbonObjC
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "CBNScannableObjectStrategy.h"
#import "CBNScannableObject.h"
#import <objc/runtime.h>

@implementation CBNScannableObjectStrategy {
    NSMutableArray<Class> *_types;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _types = [NSMutableArray array];
    }
    return self;
}

- (NSArray<Class> *)types {
    return [_types copy];
}

- (void)setTypes:(NSArray<Class> *)types {
    _types = [types mutableCopy];
}

- (BOOL)isMatchedWithAnyClass:(Class)anyClass {
    return class_getSuperclass(anyClass) == CBNScannableObject.class;
}

- (void)handleWithAnyClass:(Class)anyClass {
    [_types addObject:anyClass];
}

@end
