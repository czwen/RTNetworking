//
//  AXURLResponse.m
//  RTNetworking
//
//  Created by casa on 14-5-18.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import "AIFURLResponse.h"
#import "NSObject+AXNetworkingMethods.h"
#import "NSURLRequest+AIFNetworkingMethods.h"

@interface AIFURLResponse ()

@property (nonatomic, assign, readwrite) AIFURLResponseStatus status;
@property (nonatomic, copy, readwrite) NSString *contentString;
@property (nonatomic, copy, readwrite) id content;
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, assign, readwrite) NSInteger requestId;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, assign, readwrite) BOOL isCache;
@property (nonatomic, copy, readwrite) NSDictionary *allHeaderFields;
@property (nonatomic, copy, readwrite) NSError *error;

@end

@implementation AIFURLResponse

#pragma mark - life cycle
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData allHeaderFields:(NSDictionary *)allHeaderFields status:(AIFURLResponseStatus)status
{
    self = [super init];
    if (self) {
        self.contentString = responseString;
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        self.allHeaderFields = allHeaderFields;
    }
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData allHeaderFields:(NSDictionary *)allHeaderFields error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.contentString = [responseString AIF_defaultValue:@""];
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        self.allHeaderFields = allHeaderFields;
        self.error = error;
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
    }
    return self;
}

#pragma mark - private methods
- (AIFURLResponseStatus)responseStatusWithError:(NSError *)error
{
    if (error) {
        AIFURLResponseStatus result = AIFURLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = AIFURLResponseStatusErrorNoNetwork;
        }
        return result;
    } else {
        return AIFURLResponseStatusSuccess;
    }
}

@end
