//
//  AXRuntimeInfomation.h
//  RTNetworking
//
//  Created by casa on 14-5-6.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIFNetworkingConfiguration.h"

@interface AIFAppContext : NSObject

//凡是未声明成readonly的都是需要在初始化的时候由外面给的

@property (nonatomic, copy, readonly) NSString *appName;                //应用名称
@property (nonatomic, copy, readonly) NSString *deviceName;             //设备名称
@property (nonatomic, copy, readonly) NSString *osName;                 //系统名称
@property (nonatomic, copy, readonly) NSString *osVersion;              //系统版本
@property (nonatomic, copy, readonly) NSString *channelID;              //渠道号
@property (nonatomic, copy, readonly) NSString *appVersion;             //Bundle版本
@property (nonatomic, copy, readonly) NSString *requestTime;            //发送请求的时间
@property (nonatomic, copy, readonly) NSString *net;                    //请求网络
@property (nonatomic, copy, readonly) NSString *bundleID;
@property (nonatomic, copy, readonly) NSString *ip;

@property (nonatomic, readonly) BOOL isReachable;


// 从 AIFNetworkingConfiguration.plist获取
@property (nonatomic, copy, readonly) NSString *keychainServiceName;
@property (nonatomic, copy, readonly) NSString *udidName;
@property (nonatomic, copy, readonly) NSString *pasteboardType;


//
@property (nonatomic, copy) NSString *uid; //登录用户token
@property (nonatomic, copy) NSString *chatid; //登录用户chat id
@property (nonatomic, copy) NSString *ccid; // 用户选择的城市id

+ (instancetype)sharedInstance;

@end
