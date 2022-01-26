//
//  CBNComputer.h
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OS <NSObject>
@property (nonatomic, copy, readonly) NSString *name;
@end

@protocol CPU <NSObject>
@property (nonatomic, copy, readonly) NSString *name;
@end

@protocol ComputerProtocol <NSObject>
@property (nonatomic, strong, readonly) id<CPU> cpu;
//不能是os
@property (nonatomic, strong, readonly) id<OS> os;
@end

@interface MacOS : NSObject<OS>
@property (nonatomic, copy) NSString *name;
@end

@interface Windows : NSObject<OS>
@property (nonatomic, copy) NSString *name;
@end

@interface Intel : NSObject<CPU>
@property (nonatomic, copy) NSString *name;
@end

@interface AMD : NSObject<CPU>
@property (nonatomic, copy) NSString *name;
@end

@interface PC : NSObject<ComputerProtocol>
@property (nonatomic, strong) id<CPU> cpu;
@property (nonatomic, strong) id<OS> os;
@end

@interface Mac : NSObject<ComputerProtocol>
@property (nonatomic, strong) id<CPU> cpu;
@property (nonatomic, strong) id<OS> os;
@end


@interface CBNComputer : NSObject

@end

NS_ASSUME_NONNULL_END
