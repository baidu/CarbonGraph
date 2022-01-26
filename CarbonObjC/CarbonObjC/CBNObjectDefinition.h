//
//  CBNObjectDefinition.h
//  CarbonObjC
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import <UIKit/UIKit.h>

@class CBNObjectContext;
@class DefinitionBuilder;
@class CBNObjectScope;

NS_ASSUME_NONNULL_BEGIN

@class CBNClassFactoryDefinitionBuilder;

typedef void(^CBNDefineCompleted)(CBNObjectContext *context, NSObject *obj);
typedef NSObject* _Nonnull(^CBNFactoryDefineCompleted)(CBNObjectContext *context);


@class CBNAutowiredDefinitionBuilder;
@class CBNKeyDefinitionBuilder;


/// Builder base class.
@interface CBNDefinitionBuilder : NSObject
@end

/// Responsible for collecting defined attributes, building and registering
@interface CBNObjectDefinition : NSObject

/// Objc convenient entry for building and registering objects
+ (DefinitionBuilder *)define:(void(^)(CBNKeyDefinitionBuilder *builder))block;

@end


@interface CBNClassFactoryDefinitionBuilder : CBNDefinitionBuilder

- (CBNAutowiredDefinitionBuilder *(^)(Class cls))cls;

@end


@interface CBNFactoryDefinitionBuilder : CBNClassFactoryDefinitionBuilder

- (CBNClassFactoryDefinitionBuilder *(^)(CBNFactoryDefineCompleted _Nullable blk))factory;

@end


@interface CBNAliasDefinitionBuilder : CBNFactoryDefinitionBuilder

/// Protocol alias, multiple aliases can be used consecutively
- (CBNAliasDefinitionBuilder *(^)(Protocol *protocol))aliasProtocol;

/// Note: The alias array will overwrite the previous aliasProtocol, so multiple aliasProtocol or a single alias array are usually used.
- (CBNFactoryDefinitionBuilder *(^)(NSArray<Protocol *> *alias))alias;

@end


@interface CBNKeyDefinitionBuilder : CBNDefinitionBuilder

- (CBNAliasDefinitionBuilder *(^)(Protocol *protocol))protocol;

@end


@interface CBNActionDefinitionBuilder : CBNDefinitionBuilder

- (CBNActionDefinitionBuilder *(^)(CBNDefineCompleted completed))completed;

@end


@interface CBNAttributeDefinitionBuilder : CBNActionDefinitionBuilder

/// Define object's scope is `CBNObjectScope.prototype`. Default scope.
@property (nonatomic, copy, readonly) CBNActionDefinitionBuilder *(^prototype)(void);
/// Define object's scope is `CBNObjectScope.singleton`.
@property (nonatomic, copy, readonly) CBNActionDefinitionBuilder *(^singleton)(void);
/// Define object's scope is `CBNObjectScope.singletonWeak`.
@property (nonatomic, copy, readonly) CBNActionDefinitionBuilder *(^singletonWeak)(void);

- (CBNActionDefinitionBuilder *(^)(CBNObjectScope *scope))scope;

@end


@interface CBNAutowiredDefinitionBuilder : CBNAttributeDefinitionBuilder

- (CBNAutowiredDefinitionBuilder *(^)(NSString *property))propertyName;

/// Note: The propertiesName array will overwrite the previous propertyName, so multiple propertyNames or a single propertiesName array are usually used.
- (CBNAttributeDefinitionBuilder *(^)(NSArray<NSString *> *properties))propertiesName;

@end


#pragma mark - Autobox Protocol And Class

#define cbn_protocol(p) cbn_protocol(@protocol(p))
#define cbn_cls(c) cbn_cls(c.class)
#define cbn_aliasProtocol(p) cbn_aliasProtocol(@protocol(p))

#define cbn_alias(p) cbn_alias(@[@protocol(p)])
#define cbn_alias2(p1, p2) cbn_alias2(@[@protocol(p1), @protocol(p2)])
#define cbn_alias3(p1, p2, p3) cbn_alias3(@[@protocol(p1), @protocol(p2), @protocol(p3)])
#define cbn_alias4(p1, p2, p3, p4) cbn_alias4(@[@protocol(p1), @protocol(p2), @protocol(p3), @protocol(p4)])
#define cbn_alias5(p1, p2, p3, p4, p5) cbn_alias5(@[@protocol(p1), @protocol(p2), @protocol(p3), @protocol(p4), @protocol(p5)])

@interface CBNKeyDefinitionBuilder (AutoBox)

- (CBNAliasDefinitionBuilder *(^)(Protocol *protocol))cbn_protocol;

@end

@interface CBNClassFactoryDefinitionBuilder (AutoBox)

- (CBNAutowiredDefinitionBuilder *(^)(Class cls))cbn_cls;

@end

@interface CBNAliasDefinitionBuilder (AutoBox)

- (CBNAliasDefinitionBuilder *(^)(Protocol *protocol))cbn_aliasProtocol;
- (CBNFactoryDefinitionBuilder *(^)(NSArray<Protocol *> *alias))cbn_alias;
- (CBNFactoryDefinitionBuilder *(^)(NSArray<Protocol *> *alias))cbn_alias2;
- (CBNFactoryDefinitionBuilder *(^)(NSArray<Protocol *> *alias))cbn_alias3;
- (CBNFactoryDefinitionBuilder *(^)(NSArray<Protocol *> *alias))cbn_alias4;
- (CBNFactoryDefinitionBuilder *(^)(NSArray<Protocol *> *alias))cbn_alias5;

@end

NS_ASSUME_NONNULL_END


