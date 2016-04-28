//
//  AXService.h
//  RTNetworking
//
//  Created by casa on 14-5-15.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIFSignatureProtocol.h"
// 所有AIFService的派生类都要符合这个protocal
@protocol AIFServiceProtocal <NSObject>

@property (nonatomic, readonly) BOOL isOnline;

@property (nonatomic, readonly) NSString *offlineApiBaseUrl;
@property (nonatomic, readonly) NSString *onlineApiBaseUrl;

@property (nonatomic, readonly) NSString *offlineApiVersion;
@property (nonatomic, readonly) NSString *onlineApiVersion;

@property (nonatomic, readonly) NSDictionary *onlinePublicKey;
@property (nonatomic, readonly) NSDictionary *offlinePublicKey;

@property (nonatomic, readonly) NSString *onlinePrivateKey;
@property (nonatomic, readonly) NSString *offlinePrivateKey;

@property (nonatomic, readonly) BOOL onlineIsSingtureAllParamters;
@property (nonatomic, readonly) BOOL offlineIsSingtureAllParamters;

@property (nonatomic, strong, readonly) NSDictionary *serviceCommonParamsDictionary;
@property (nonatomic, strong, readonly) NSDictionary *serviceHeadersDictionary;

@end

@interface AIFService : NSObject

@property (nonatomic, strong, readonly) NSDictionary *headersDictionary;
@property (nonatomic, strong, readonly) NSDictionary *commonParamsDictionary;
@property (nonatomic, strong, readonly) NSDictionary *publicKey;
@property (nonatomic, strong, readonly) NSString *privateKey;
@property (nonatomic, strong, readonly) NSString *apiBaseUrl;
@property (nonatomic, strong, readonly) NSString *apiVersion;
@property (nonatomic, readonly) BOOL isSingtureAllParamters;

@property (nonatomic, weak) id<AIFServiceProtocal> child;
@property (nonatomic, weak) id<AIFSignatureProtocol> signature;

@end
