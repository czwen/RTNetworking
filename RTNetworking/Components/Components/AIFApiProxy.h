//
//  AXApiProxy.h
//  RTNetworking
//
//  Created by casa on 14-5-12.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIFURLResponse.h"

typedef void(^AXCallback)(AIFURLResponse *response);
typedef void(^AXProgressCallback)(CGFloat progress);

@interface AIFApiProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName fileName:(NSString *)fileName additionalHTTPHeader:(NSDictionary *)headers progress:(AXProgressCallback)progress success:(AXCallback)success fail:(AXCallback)fail;

- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName fileName:(NSString *)fileName additionalHTTPHeader:(NSDictionary *)headers progress:(AXProgressCallback)progress success:(AXCallback)success fail:(AXCallback)fail;

- (NSInteger)callPUTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName fileName:(NSString *)fileName additionalHTTPHeader:(NSDictionary *)headers progress:(AXProgressCallback)progress success:(AXCallback)success fail:(AXCallback)fail;

- (NSInteger)callDELETEWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName fileName:(NSString *)fileName additionalHTTPHeader:(NSDictionary *)headers progress:(AXProgressCallback)progress success:(AXCallback)success fail:(AXCallback)fail;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end
