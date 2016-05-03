//
//  AIFServiceTest.m
//  RTNetworking
//
//  Created by ChenZhiWen on 16/4/27.
//  Copyright © 2016 anjuke. All rights reserved.
//

#import "AIFServiceTest.h"
#import "AIFAppContext.h"

@interface AIFServiceTest()
@end
@implementation AIFServiceTest
#pragma mark - AIFServiceProtocal
- (BOOL)isOnline
{
    return YES;
}

- (NSString *)onlineApiBaseUrl
{
    return @"";
}

- (NSString *)onlineApiVersion
{
    return @"api/v1";
}

- (NSString *)onlinePrivateKey
{
    return @"";
}

- (NSString *)onlinePublicKey
{
    return @"";
}

- (NSString *)offlineApiBaseUrl
{
    return self.onlineApiBaseUrl;
}

- (NSString *)offlineApiVersion
{
    return self.onlineApiVersion;
}

- (NSString *)offlinePrivateKey
{
    return self.onlinePrivateKey;
}

- (NSString *)offlinePublicKey
{
    return self.onlinePublicKey;
}

- (BOOL)onlineIsSingtureAllParamters
{
    return YES;
}

- (BOOL)offlineIsSingtureAllParamters
{
    return YES;
}

- (NSDictionary *)serviceHeadersDictionary
{
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    [headerDic setValue:@"application/json" forKey:@"Accept"];
    [headerDic setValue:@"application/json" forKey:@"Content-Type"];
    NSDictionary *loginResult = [[NSUserDefaults standardUserDefaults] objectForKey:@"______"];
    if (loginResult[@"auth_token"]) {
        [headerDic setValue:loginResult[@"auth_token"] forKey:@"AuthToken"];
    }
    return headerDic;
}

- (NSDictionary *)serviceCommonParamsDictionary
{
    NSLog([@{
            @"appName":[AIFAppContext sharedInstance].appName,
            @"deviceName":[AIFAppContext sharedInstance].deviceName,
            @"osName":[AIFAppContext sharedInstance].osName,
            @"osVersion":[AIFAppContext sharedInstance].osVersion,
            @"channelID":[AIFAppContext sharedInstance].channelID,
            @"appVersion":[AIFAppContext sharedInstance].appVersion,
            @"requestTime":[AIFAppContext sharedInstance].requestTime,
            @"net":[AIFAppContext sharedInstance].net,
            @"bundleID":[AIFAppContext sharedInstance].bundleID,
            @"ip":[AIFAppContext sharedInstance].ip,
            } description],nil);
    return @{
             @"appName":[AIFAppContext sharedInstance].appName,
             @"deviceName":[AIFAppContext sharedInstance].deviceName,
             @"osName":[AIFAppContext sharedInstance].osName,
             @"osVersion":[AIFAppContext sharedInstance].osVersion,
             @"channelID":[AIFAppContext sharedInstance].channelID,
             @"appVersion":[AIFAppContext sharedInstance].appVersion,
             @"requestTime":[AIFAppContext sharedInstance].requestTime,
             @"net":[AIFAppContext sharedInstance].net,
             @"bundleID":[AIFAppContext sharedInstance].bundleID,
             @"ip":[AIFAppContext sharedInstance].ip,
             };
}

- (NSDictionary *)signWithSigParams:(NSDictionary *)allParams methodName:(NSString *)methodName apiVersion:(NSString *)apiVersion privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey
{
    return @{@"sign":@"123123123"};
}


@end
