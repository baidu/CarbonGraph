//
//  CBNComputer.m
//  CarbonObjCTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "CBNComputer.h"

@implementation MacOS

- (NSString *)name {
    return @"Big Sur";
}

@end

@implementation Windows

- (NSString *)name {
    return @"Win10";
}

@end


@implementation Intel

- (NSString *)name {
    return @"Inter i7";
}

@end

@implementation AMD

- (NSString *)name {
    return @"AMD A8";
}

@end


@implementation Mac

- (NSString *)description {
    return [NSString stringWithFormat:@"Mac CPU: %@, OS: %@", self.cpu.name, self.os.name];
}

@end


@implementation PC

- (NSString *)description {
    return [NSString stringWithFormat:@"PC CPU: %@, OS: %@", self.cpu.name, self.os.name];
}

@end

@implementation CBNComputer

@end

@implementation CBNWrapperCPU

@end
