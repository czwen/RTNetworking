//
//  AXService.m
//  RTNetworking
//
//  Created by casa on 14-5-15.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import "AIFService.h"
#import "NSObject+AXNetworkingMethods.h"

@implementation AIFService

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(AIFServiceProtocal)]) {
            self.child = (id<AIFServiceProtocal>)self;
        }
        if ([self conformsToProtocol:@protocol(AIFSignatureProtocol)]) {
            self.signature = (id<AIFSignatureProtocol>)self;
        }
    }
    return self;
}

#pragma mark - getters and setters
- (NSString *)privateKey
{
    return self.child.isOnline ? self.child.onlinePrivateKey : self.child.offlinePrivateKey;
}

- (NSDictionary *)publicKey
{
    /*************
     *  example  *
     *************
     
     @{
        @"app_key":@"publicKey"
     }
     
     */
    return self.child.isOnline ? self.child.onlinePublicKey : self.child.offlinePublicKey;
}

- (NSString *)apiBaseUrl
{
    return self.child.isOnline ? self.child.onlineApiBaseUrl : self.child.offlineApiBaseUrl;
}

- (NSString *)apiVersion
{
    return self.child.isOnline ? self.child.onlineApiVersion : self.child.offlineApiVersion;
}

- (BOOL)isSingtureAllParamters
{
    return self.child.isOnline ? self.child.onlineIsSingtureAllParamters : self.child.offlineIsSingtureAllParamters;
}

- (NSDictionary *)headersDictionary
{
    return self.child.serviceHeadersDictionary;
}

- (NSDictionary *)commonParamsDictionary
{
    return self.child.serviceCommonParamsDictionary;
}
@end
