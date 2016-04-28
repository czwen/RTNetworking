//
//  AIFServiceTest.m
//  RTNetworking
//
//  Created by ChenZhiWen on 16/4/27.
//  Copyright © 2016 anjuke. All rights reserved.
//

#import "AIFServiceTest.h"

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

- (NSDictionary *)onlinePublicKey
{
    return @{@"api_key":@"1123"};
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

- (NSDictionary *)offlinePublicKey
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
    [headerDic addEntriesFromDictionary:self.publicKey];
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
    return @{
             @"api":@"api"
             };
}

- (NSDictionary *)signWithSigParams:(NSDictionary *)allParams methodName:(NSString *)methodName apiVersion:(NSString *)apiVersion privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey
{
    return @{@"sign":@"123123123"};
}


@end
