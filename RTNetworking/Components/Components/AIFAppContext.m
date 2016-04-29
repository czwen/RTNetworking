//
//  AXRuntimeInfomation.m
//  RTNetworking
//
//  Created by casa on 14-5-6.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import "AIFAppContext.h"
#import "NSObject+AXNetworkingMethods.h"
#import "UIDevice+IdentifierAddition.h"
#import "AFNetworkReachabilityManager.h"
#import "AIFLogger.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

static NSString *kAIFKeychainServiceName = @"AIFKeychainServiceName";
static NSString *kAIFUDIDName = @"AIFUDIDName";
static NSString *kAIFPasteboardType = @"AIFPasteboardType";
static NSString *kChannelID = @"ChannelID";

@interface AIFAppContext ()
@property (nonatomic, strong) NSDictionary *plist;
@property (nonatomic, strong) UIDevice *device;


@property (nonatomic, copy, readwrite) NSString *appName;                //应用名称
@property (nonatomic, copy, readwrite) NSString *deviceName;             //设备名称
@property (nonatomic, copy, readwrite) NSString *osName;                 //系统名称
@property (nonatomic, copy, readwrite) NSString *osVersion;              //系统版本
@property (nonatomic, copy, readwrite) NSString *channelID;              //渠道号
@property (nonatomic, copy, readwrite) NSString *appVersion;             //Bundle版本
@property (nonatomic, copy, readwrite) NSString *requestTime;            //发送请求的时间
@property (nonatomic, copy, readwrite) NSString *net;                    //请求网络
@property (nonatomic, copy, readwrite) NSString *bundleID;
@property (nonatomic, copy, readwrite) NSString *ip;

@property (nonatomic, readwrite) BOOL isReachable;


@property (nonatomic, copy, readwrite) NSString *keychainServiceName;
@property (nonatomic, copy, readwrite) NSString *udidName;
@property (nonatomic, copy, readwrite) NSString *pasteboardType;
@end

@implementation AIFAppContext

#pragma mark - getters and setters
- (UIDevice *)device
{
    if (_device == nil) {
        _device = [UIDevice currentDevice];
    }
    return _device;
}

- (NSString *)deviceName
{
    if (_deviceName == nil) {
        _deviceName = [[self.device.localizedModel stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] AIF_defaultValue:@""];
    }
    return _deviceName;
}

- (NSString *)osName
{
    if (_osName == nil) {
        _osName = [[self.device.systemName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] AIF_defaultValue:@""];
    }
    return _osName;
}
 - (NSString *)osVersion
{
    if (_osVersion == nil) {
        _osVersion = [self.device systemVersion];
    }
    return _osVersion;
}

- (NSString *)appVersion
{
    if (_appVersion == nil) {
        _appVersion = @"";
        _appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    }
    return _appVersion;
}

- (NSString *)channelID
{
    if (_channelID == nil) {
        _channelID = @"";
        _channelID = [self.plist valueForKey:kChannelID];
    }
    return _channelID;
}

- (NSString *)requestTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:NSLocalizedString(@"yyyyMMddHHmmss", nil)];
    return [formatter stringFromDate:[NSDate date]];
}

- (NSString *)appName
{
    if (_appName == nil) {
        _appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    }
    return _appName;
}

- (NSString *)net
{
    _net = @"";
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN) {
        _net = @"2G3G4G";
    }
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi) {
        _net = @"WiFi";
    }

    return _net;
}

- (NSString *)ip
{
    if (_ip == nil) {
        _ip = @"Error";
        struct ifaddrs *interfaces = NULL;
        struct ifaddrs *temp_addr = NULL;
        int success = 0;
        // retrieve the current interfaces - returns 0 on success
        success = getifaddrs(&interfaces);
        if (success == 0) {
            // Loop through linked list of interfaces
            temp_addr = interfaces;
            while(temp_addr != NULL) {
                if(temp_addr->ifa_addr->sa_family == AF_INET) {
                    // Check if interface is en0 which is the wifi connection on the iPhone
                    if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                        // Get NSString from C String
                        _ip = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    }
                }
                temp_addr = temp_addr->ifa_next;
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return _ip;
}

- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

- (NSDictionary *)plist{
    if (!_plist) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AIFNetworkingConfiguration" ofType:@"plist"];
        _plist = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    return _plist;
}

- (NSString *)keychainServiceName{
    if (_keychainServiceName == nil) {
        _keychainServiceName = [[self.plist valueForKey:kAIFKeychainServiceName] AIF_defaultValue:[self bundleID]];
    }
    return _keychainServiceName;
}

- (NSString *)udidName{
    if (_udidName == nil) {
        _udidName = [[self.plist valueForKey:kAIFUDIDName] AIF_defaultValue:[self bundleID]];
    }
    return _udidName;
}

- (NSString *)pasteboardType{
    if (_pasteboardType == nil) {
        _pasteboardType = [[self.plist valueForKey:kAIFPasteboardType] AIF_defaultValue:[self bundleID]];
    }
    return _pasteboardType;
}

- (NSString *)bundleID{
    return [[NSBundle mainBundle] bundleIdentifier];
}

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static AIFAppContext *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AIFAppContext alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}

#pragma mark - overrided methods
- (instancetype)init
{
    self = [super init];
    return self;
}

@end
