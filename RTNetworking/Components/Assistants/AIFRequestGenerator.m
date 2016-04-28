//
//  AXRequestGenerator.m
//  RTNetworking
//
//  Created by casa on 14-5-14.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import "AIFRequestGenerator.h"
#import "AIFServiceFactory.h"
#import "AIFCommonParamsGenerator.h"
#import "NSDictionary+AXNetworkingMethods.h"
#import "AIFNetworkingConfiguration.h"
#import "NSObject+AXNetworkingMethods.h"
#import <AFNetworking/AFNetworking.h>
#import "AIFService.h"
#import "NSObject+AXNetworkingMethods.h"
#import "AIFLogger.h"
#import "NSURLRequest+AIFNetworkingMethods.h"

@interface AIFRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation AIFRequestGenerator

#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kAIFNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static AIFRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AIFRequestGenerator alloc] init];
    });
    return sharedInstance;
}

- (NSURLRequest *)generateRequestMethod:(NSString *)method withServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    AIFService *service = [[AIFServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    
    NSDictionary *commonParameters = [service commonParamsDictionary];
    NSMutableDictionary *sigParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    NSMutableDictionary *allParams;
    NSDictionary *signature;
    
    BOOL needSignture = [service.signature respondsToSelector:@selector(signWithSigParams:methodName:apiVersion:privateKey:publicKey:)];
    
    if (needSignture) {
        
        [sigParams addEntriesFromDictionary:service.publicKey];
        
        if (service.isSingtureAllParamters) {
            
            signature = [service.signature signWithSigParams:allParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey.allValues.firstObject];
            
        }else{
            
            signature = [service.signature signWithSigParams:sigParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey.allValues.firstObject];
            
        }
        [sigParams addEntriesFromDictionary:signature];
    }
    
    [sigParams addEntriesFromDictionary:commonParameters];
    allParams = sigParams;
    
    NSString *urlString = [[service.apiBaseUrl stringByAppendingPathComponent:service.apiVersion] stringByAppendingPathComponent:methodName];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:method URLString:urlString parameters:allParams error:NULL];
    
    request.allHTTPHeaderFields = [service headersDictionary];
    
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    
    [AIFLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:method];
    
    return request;
}

@end
