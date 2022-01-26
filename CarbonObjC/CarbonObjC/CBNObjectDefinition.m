//
//  CBNObjectDefinition.m
//  CarbonObjC
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

#import "CBNObjectDefinition.h"
@import CarbonCore;

typedef NS_ENUM(NSUInteger, CBNDefinitionAttributeType) {
    CBNDefinitionAttributeTypeProtocol,
    CBNDefinitionAttributeTypeAliasProtocol,
    CBNDefinitionAttributeTypeAliasProtocols,
    CBNDefinitionAttributeTypeFactory,
    CBNDefinitionAttributeTypeClass,
    CBNDefinitionAttributeTypePropertyName,
    CBNDefinitionAttributeTypePropertiesName,
    CBNDefinitionAttributeTypeScope,
    CBNDefinitionAttributeTypeCompleted
};

/// The builder proxy, the builder passes the defined attributes to the upper objectDefinition through the proxy
@protocol CBNDefinitionBuilderDelegate <NSObject>

/// Collect the attributes required for the registration instance
/// @param attr Received attributes
/// @param type Current attribute type
- (void)attachAttributes:(_Nonnull id)attr type:(CBNDefinitionAttributeType)type;

@end

@interface CBNDefinitionBuilder ()

@property (nonatomic, weak) id<CBNDefinitionBuilderDelegate> delegate;

@end

@implementation CBNDefinitionBuilder

@end

@interface CBNObjectDefinition ()<CBNDefinitionBuilderDelegate>

@property (nonatomic, strong) Protocol *defineProtocol;
@property (nonatomic, strong) Protocol *defineAliasProtocol;
@property (nonatomic, strong) NSArray<Protocol *> *defineAliasProtocols;
@property (nonatomic, strong) Class defineClass;
@property (nonatomic, copy)  CBNFactoryDefineCompleted defineFactoryCompleted;
@property (nonatomic, copy) NSString *definePropertyName;
@property (nonatomic, strong) NSArray<NSString *> *definePropertiesName;
@property (nonatomic, strong) CBNObjectScope *defineScope;
@property (nonatomic, copy) CBNDefineCompleted defineCompleted;
@property (nonatomic, strong) NSArray<CBNDefineCompleted> *defineCompleteds;

@property (nonatomic, strong) KeyDefinitionBuilder *builder;

@end

@implementation CBNObjectDefinition

+ (DefinitionBuilder *)define:(void (^)(CBNKeyDefinitionBuilder * _Nonnull builder))block {
    KeyDefinitionBuilder *builder = [[KeyDefinitionBuilder alloc] init];
    CBNObjectDefinition *definition = [[CBNObjectDefinition alloc] initWithBuilder:builder];
    CBNKeyDefinitionBuilder *keyBuilder = [[CBNKeyDefinitionBuilder alloc] init];
    keyBuilder.delegate = definition;
    block(keyBuilder);
    [definition final];
    return definition.builder;
}

- (instancetype)initWithBuilder:(KeyDefinitionBuilder *)builder {
    self = [super init];
    if (self) {
        self.builder = builder;
    }
    return self;
}

- (void)final {
    [self defineBuild];
    [self registerService];
}

- (void)defineBuild {

    id builder = [[self.builder protocol:self.defineProtocol]
                     alias:self.defineAliasProtocols];
    
    if (self.defineFactoryCompleted && [builder isKindOfClass:[DynamicFactoryDefinitionBuilder class]]) {
        builder = [[[[(DynamicFactoryDefinitionBuilder *)builder
                      factory:self.defineFactoryCompleted]
                     cls:self.defineClass]
                    propertiesName:self.definePropertiesName]
                   scope:self.defineScope];
    } else {
        [[[(DynamicFactoryDefinitionBuilder *)builder
           cls:self.defineClass]
          propertiesName:self.definePropertiesName]
         scope:self.defineScope];
    }
    
    if (self.defineCompleted && [builder isKindOfClass:[ActionDefinitionBuilder class]]) {
           [(ActionDefinitionBuilder *)builder completed:self.defineCompleted];
       }
}

- (void)registerService {
    [Application.sharedApplication.context registerWithBuilder:self.builder];
}

#pragma mark - BuilderDelegate

- (void)attachAttributes:(id)attr type:(CBNDefinitionAttributeType)type {
    if (attr == nil) {
        NSAssert(attr != nil, @"CarbonObjC: attr cannot be nil!");
        return;
    }
    switch (type) {
        case CBNDefinitionAttributeTypeProtocol:
            self.defineProtocol = attr;
            break;
        case CBNDefinitionAttributeTypeAliasProtocol:
            self.defineAliasProtocol = attr;
            if (self.defineAliasProtocols.count == 0 && attr != nil) {
                self.defineAliasProtocols = @[attr];
            } else {
                NSMutableArray *mArr = [[NSMutableArray alloc] initWithArray:self.defineAliasProtocols];
                [mArr addObject:attr];
                self.defineAliasProtocols = mArr;
            }
            break;
        case CBNDefinitionAttributeTypeAliasProtocols:
            self.defineAliasProtocols = attr;
            break;
        case CBNDefinitionAttributeTypeFactory:
            self.defineFactoryCompleted = attr;
            break;
        case CBNDefinitionAttributeTypeClass:
            self.defineClass = attr;
            break;
        case CBNDefinitionAttributeTypePropertyName:
            self.definePropertyName = attr;
            if ([attr isKindOfClass:NSString.class] && [attr length] == 0) {
                return;
            }
            if (self.definePropertiesName.count == 0) {
                self.definePropertiesName = @[attr];
            } else {
                NSMutableArray *mArr = [[NSMutableArray alloc] initWithArray:self.definePropertiesName];
                [mArr addObject:attr];
                self.definePropertiesName = mArr;
            }
            break;
        case CBNDefinitionAttributeTypePropertiesName:
            self.definePropertiesName = attr;
            break;
        case CBNDefinitionAttributeTypeScope:
            self.defineScope = attr;
            break;
        case CBNDefinitionAttributeTypeCompleted:
            self.defineCompleted = attr;
            if (self.defineCompleteds.count == 0) {
                self.defineCompleteds = @[attr];
            } else {
                NSMutableArray *mArr = [[NSMutableArray alloc] initWithArray:self.defineCompleteds];
                [mArr addObject:attr];
                self.defineCompleteds = mArr;
            }
            break;
        default:
            break;
    }
}

@end

#pragma mark - CBNKeyDefinitionBuilder

@interface CBNKeyDefinitionBuilder ()

@end

@implementation CBNKeyDefinitionBuilder

- (CBNAliasDefinitionBuilder * _Nonnull (^)(Protocol * _Nonnull protocol))protocol {
    return ^CBNAliasDefinitionBuilder *(Protocol *p) {
        return [self defineProtocol:p];
    };
}

- (CBNAliasDefinitionBuilder *)defineProtocol:(Protocol *)p {
    [self.delegate attachAttributes:p type:CBNDefinitionAttributeTypeProtocol];
    CBNAliasDefinitionBuilder *newbuilder = [[CBNAliasDefinitionBuilder alloc] init];
    newbuilder.delegate = self.delegate;
    return newbuilder;
}

@end

#pragma mark - CBNClassFactoryDefinitionBuilder

@implementation CBNClassFactoryDefinitionBuilder

- (CBNAutowiredDefinitionBuilder * _Nonnull (^)(Class _Nonnull __unsafe_unretained cls))cls {
    return ^CBNAutowiredDefinitionBuilder *(Class cls) {
        return [self defineClass:cls];
    };
}

- (CBNAutowiredDefinitionBuilder *)defineClass:(Class)cls {
    [self.delegate attachAttributes:cls type:CBNDefinitionAttributeTypeClass];
    CBNAutowiredDefinitionBuilder *newbuilder =[[CBNAutowiredDefinitionBuilder alloc] init];
    newbuilder.delegate = self.delegate;
    return newbuilder;
}

@end

#pragma mark - CBNFactoryDefinitionBuilder
@implementation CBNFactoryDefinitionBuilder

- (CBNClassFactoryDefinitionBuilder * _Nonnull (^)(CBNFactoryDefineCompleted _Nullable block))factory {
    return ^CBNClassFactoryDefinitionBuilder *(CBNFactoryDefineCompleted blk) {
        return [self defineFactory:blk];
    };
}

- (CBNClassFactoryDefinitionBuilder *)defineFactory:(CBNFactoryDefineCompleted)blk {
    [self.delegate attachAttributes:blk type:CBNDefinitionAttributeTypeFactory];
    CBNClassFactoryDefinitionBuilder *newbuilder = [[CBNClassFactoryDefinitionBuilder alloc] init];
    newbuilder.delegate = self.delegate;
    return newbuilder;
}

@end

#pragma mark - CBNAliasDefinitionBuilder

@implementation CBNAliasDefinitionBuilder

- (CBNAliasDefinitionBuilder * _Nonnull (^)(Protocol * _Nonnull protocol))aliasProtocol {
    return ^CBNAliasDefinitionBuilder *(Protocol *p) {
        return [self defineAliasProtocol:p];
    };
}

- (CBNFactoryDefinitionBuilder * _Nonnull (^)(NSArray<Protocol *> * _Nonnull alias))alias {
    return ^CBNFactoryDefinitionBuilder *(NSArray<Protocol *> *protocols) {
        return [self defineAlias:protocols];
    };
}

- (CBNAliasDefinitionBuilder *)defineAliasProtocol:(Protocol *)protocol {
    [self.delegate attachAttributes:protocol type:CBNDefinitionAttributeTypeAliasProtocol];
    CBNAliasDefinitionBuilder *newbuilder = [[CBNAliasDefinitionBuilder alloc] init];
    newbuilder.delegate = self.delegate;
    return newbuilder;
}

- (CBNFactoryDefinitionBuilder *)defineAlias:(NSArray<Protocol *> *)protocols {
    [self.delegate attachAttributes:protocols type:CBNDefinitionAttributeTypeAliasProtocols];
    CBNFactoryDefinitionBuilder *newbuilder = [[CBNFactoryDefinitionBuilder alloc] init];
    newbuilder.delegate = self.delegate;
    return newbuilder;
}

@end

#pragma mark - CBNAutowiredDefinitionBuilder

@implementation CBNAutowiredDefinitionBuilder

- (CBNAutowiredDefinitionBuilder * _Nonnull (^)(NSString * _Nonnull property))propertyName {
    return ^CBNAutowiredDefinitionBuilder *(NSString *propertyName) {
        return [self defineProperty:propertyName];
    };
}

- (CBNAttributeDefinitionBuilder * _Nonnull (^)(NSArray<NSString *> * _Nonnull properties))propertiesName {
    return ^CBNAttributeDefinitionBuilder *(NSArray<NSString *> *propertiesName) {
        return [self definePropertiesName:propertiesName];
    };
}

- (CBNAutowiredDefinitionBuilder *)defineProperty:(NSString *)propertyName {
    [self.delegate attachAttributes:propertyName type:CBNDefinitionAttributeTypePropertyName];
    CBNAutowiredDefinitionBuilder *newbuilder = [[CBNAutowiredDefinitionBuilder alloc] init];
    newbuilder.delegate = self.delegate;
    return newbuilder;
}

- (CBNAttributeDefinitionBuilder *)definePropertiesName:(NSArray<NSString *> *)propertiesName {
    [self.delegate attachAttributes:propertiesName type:CBNDefinitionAttributeTypePropertiesName];
    CBNAttributeDefinitionBuilder *newbuilder = [[CBNAttributeDefinitionBuilder alloc] init];
    newbuilder.delegate = self.delegate;
    return newbuilder;
}

@end

#pragma mark - CBNAttributeDefinitionBuilder

@implementation CBNAttributeDefinitionBuilder

- (CBNActionDefinitionBuilder * _Nonnull (^)(void))singleton {
    return ^CBNActionDefinitionBuilder *(void) {
        return [self defineScope:CBNObjectScope.singleton];
    };
}

- (CBNActionDefinitionBuilder * _Nonnull (^)(void))singletonWeak {
    return ^CBNActionDefinitionBuilder *(void) {
        return [self defineScope:CBNObjectScope.singletonWeak];
    };
}

- (CBNActionDefinitionBuilder * _Nonnull (^)(void))prototype {
    return ^CBNActionDefinitionBuilder *(void) {
        return [self defineScope:CBNObjectScope.prototype];
    };
}

- (CBNActionDefinitionBuilder * _Nonnull (^)(CBNObjectScope * _Nonnull scope))scope {
    return ^CBNActionDefinitionBuilder *(CBNObjectScope *s) {
        return [self defineScope:s];
    };
}

- (CBNActionDefinitionBuilder *)defineScope:(CBNObjectScope *)scope {
    [self.delegate attachAttributes:scope type:CBNDefinitionAttributeTypeScope];
    CBNActionDefinitionBuilder *newbuilder = [[CBNActionDefinitionBuilder alloc] init];
    newbuilder.delegate = self.delegate;
    return newbuilder;
}

@end

#pragma mark - CBNActionDefinitionBuilder

@implementation CBNActionDefinitionBuilder

- (CBNActionDefinitionBuilder * _Nonnull (^)(CBNDefineCompleted _Nonnull completed))completed {
    return ^CBNActionDefinitionBuilder *(CBNDefineCompleted blk) {
        return [self defineCompleted:blk];
    };
}

- (CBNActionDefinitionBuilder *)defineCompleted:(CBNDefineCompleted)block {
    [self.delegate attachAttributes:block type:CBNDefinitionAttributeTypeCompleted];
    CBNActionDefinitionBuilder *newbuilder = [[CBNActionDefinitionBuilder alloc] init];
    newbuilder.delegate = self.delegate;
    return newbuilder;
}

@end

#pragma mark - Autobox Protocol And Class

@implementation CBNKeyDefinitionBuilder (AutoBox)

- (CBNAliasDefinitionBuilder * _Nonnull (^)(Protocol * _Nonnull protocol))cbn_protocol {
    return ^CBNAliasDefinitionBuilder *(Protocol *p) {
        return [self defineProtocol:p];
    };
}

@end

@implementation CBNClassFactoryDefinitionBuilder (AutoBox)

- (CBNAutowiredDefinitionBuilder * _Nonnull (^)(Class _Nonnull __unsafe_unretained cls))cbn_cls {
    return ^CBNAutowiredDefinitionBuilder *(Class cls) {
        return [self defineClass:cls];
    };
}

@end

@implementation CBNAliasDefinitionBuilder (AutoBox)

- (CBNAliasDefinitionBuilder * _Nonnull (^)(Protocol * _Nonnull protocol))cbn_aliasProtocol {
    return ^CBNAliasDefinitionBuilder *(Protocol *p) {
        return [self defineAliasProtocol:p];
    };
}

- (CBNFactoryDefinitionBuilder * _Nonnull (^)(NSArray<Protocol *> * _Nonnull))cbn_alias {
    return ^CBNFactoryDefinitionBuilder *(NSArray<Protocol *> *protocols) {
        return [self defineAlias:protocols];
    };
}

- (CBNFactoryDefinitionBuilder * _Nonnull (^)(NSArray<Protocol *> * _Nonnull))cbn_alias2 {
    return ^CBNFactoryDefinitionBuilder *(NSArray<Protocol *> *protocols) {
        return [self defineAlias:protocols];
    };
}

- (CBNFactoryDefinitionBuilder * _Nonnull (^)(NSArray<Protocol *> * _Nonnull))cbn_alias3 {
    return ^CBNFactoryDefinitionBuilder *(NSArray<Protocol *> *protocols) {
        return [self defineAlias:protocols];
    };
}

- (CBNFactoryDefinitionBuilder * _Nonnull (^)(NSArray<Protocol *> * _Nonnull))cbn_alias4 {
    return ^CBNFactoryDefinitionBuilder *(NSArray<Protocol *> *protocols) {
        return [self defineAlias:protocols];
    };
}

- (CBNFactoryDefinitionBuilder * _Nonnull (^)(NSArray<Protocol *> * _Nonnull))cbn_alias5 {
    return ^CBNFactoryDefinitionBuilder *(NSArray<Protocol *> *protocols) {
        return [self defineAlias:protocols];
    };
}

@end
