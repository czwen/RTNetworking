//
//  TestManager.m
//  RTNetworking
//
//  Created by ChenZhiWen on 16/4/27.
//  Copyright © 2016 anjuke. All rights reserved.
//

#import "TestManager.h"

@implementation TestManager
- (instancetype)init{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

- (NSString *)serviceType
{
    return @"Test";
}

- (NSString *)methodName
{
    return @"register/code";
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypeGet;
}

- (BOOL)manager:(RTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data{
    return YES;
}

- (BOOL)manager:(RTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data{
    return YES;
}

@end
