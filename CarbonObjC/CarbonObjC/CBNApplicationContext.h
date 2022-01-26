//
//  CBNApplicationContext.h
//  CarbonObjC
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#ifndef CBNApplicationContext_h
#define CBNApplicationContext_h
#import <UIKit/UIKit.h>
#import <CarbonCore/CarbonCore-Swift.h>
#import "CBNObjectDefinition.h"
#import "CBNApplication.h"
#import "CBNConfiguration.h"

#define CBN_APP_CONTEXT UIApplication.sharedApplication.context

#define CBN_RESOLVE(PROTOCOL) CBN_RESOLVE_BY_TYPE(PROTOCOL)
#define CBN_RESOLVE_CLASS(PROTOCOL) [CBN_APP_CONTEXT objectClass:@protocol(PROTOCOL)]

#define CBN_RESOLVE_BY_TYPE(PROTOCOL) (id<PROTOCOL>)CBN_APP_CONTEXT[@protocol(PROTOCOL)]
#define CBN_RESOLVE_BY_NAME(NAME) CBN_RESOLVE_BY(NSObject, NAME)
#define CBN_RESOLVE_BY(PROTOCOL, NAME) (id<PROTOCOL>)[CBN_APP_CONTEXT objectWithProtocol:@protocol(PROTOCOL) name:NAME]
#define CBN_PROPERTY(CLASS, PROPERTY) @(((void)(NO && ((void)[[CLASS alloc] init].PROPERTY, NO)), # PROPERTY))

#endif /* CBNApplicationContext_h */
