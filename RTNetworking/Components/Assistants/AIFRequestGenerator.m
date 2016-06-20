//
//  AXRequestGenerator.m
//  RTNetworking
//
//  Created by casa on 14-5-14.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import "AIFRequestGenerator.h"
#import "AIFServiceFactory.h"
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
@property (nonatomic, strong) AFJSONRequestSerializer *jsonRequestSerializer;

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

- (AFJSONRequestSerializer *)jsonRequestSerializer
{
    if (_jsonRequestSerializer == nil) {
        _jsonRequestSerializer = [AFJSONRequestSerializer serializer];
        _jsonRequestSerializer.timeoutInterval = kAIFNetworkingTimeoutSeconds;
        _jsonRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _jsonRequestSerializer;
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

- (NSURLRequest *)generateRequestMethod:(NSString *)method withServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName additionalHTTPHeader:(NSDictionary *)headers
{
    AIFService *service = [[AIFServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    
    NSDictionary *commonParameters = [service commonParamsDictionary];
    NSMutableDictionary *sigParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    NSMutableDictionary *allParams;
    NSDictionary *signature;
    
    __block NSDictionary *dataParams;
    
    [[[requestParams allKeys] copy] enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = requestParams[key];
        
        if ([value isKindOfClass:[NSData class]]) {
            dataParams = @{key:value};
            [sigParams removeObjectForKey:key];
        }
    }];
    
    BOOL needSignture = [service.signature respondsToSelector:@selector(signWithSigParams:methodName:apiVersion:privateKey:publicKey:)];
    
    if (needSignture) {
    
        if (service.isSingtureAllParamters) {
            
            signature = [service.signature signWithSigParams:allParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey];
            
        }else{
            
            signature = [service.signature signWithSigParams:sigParams methodName:methodName apiVersion:service.apiVersion privateKey:service.privateKey publicKey:service.publicKey];
            
        }
        [sigParams addEntriesFromDictionary:signature];
    }
    
    [sigParams addEntriesFromDictionary:commonParameters];
    allParams = sigParams;
    
    NSString *urlString = [[service.apiBaseUrl stringByAppendingPathComponent:service.apiVersion] stringByAppendingPathComponent:methodName];
    
    NSMutableDictionary *headerFiedls = [NSMutableDictionary dictionaryWithDictionary:[service headersDictionary]];
    [headerFiedls addEntriesFromDictionary:headers];
    
    NSMutableURLRequest *request;
    
    NSString *contentType = [headerFiedls valueForKey:@"Content-Type"];
    
    if ([contentType isEqualToString:@"application/json"]) {
        request = [self.jsonRequestSerializer requestWithMethod:method URLString:urlString parameters:allParams error:NULL];
    }else if ([contentType isEqualToString:@"multipart/form-data"]) {
        request = [self.httpRequestSerializer multipartFormRequestWithMethod:method URLString:urlString parameters:allParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:dataParams.allValues.firstObject name:dataParams.allKeys.firstObject fileName:@"file" mimeType:@""];
        } error:nil];
        [headerFiedls removeObjectForKey:@"Content-Type"];
    }else{
        request = [self.httpRequestSerializer requestWithMethod:method URLString:urlString parameters:allParams error:NULL];
    }
    
    request.allHTTPHeaderFields = headerFiedls;
    
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    
    [AIFLogger logDebugInfoWithRequest:request apiName:methodName service:service requestParams:requestParams httpMethod:method];
    
    return request;
}

@end
