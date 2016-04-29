//
//  AXNetworkingConfiguration.h
//  RTNetworking
//
//  Created by casa on 14-5-13.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//


#ifndef AIFNetworking_AIFNetworkingConfiguration_h
#define AIFNetworking_AIFNetworkingConfiguration_h

typedef NS_ENUM(NSUInteger, AIFURLResponseStatus)
{
    AIFURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的RTApiBaseManager来决定。
    AIFURLResponseStatusErrorTimeout,
    AIFURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};

static NSTimeInterval kAIFNetworkingTimeoutSeconds = 20.0f;

static BOOL kAIFShouldCache = NO;
static NSTimeInterval kAIFCacheOutdateTimeSeconds = 300; // 5分钟的cache过期时间
static NSUInteger kAIFCacheCountLimit = 1000; // 最多1000条cache

#endif
