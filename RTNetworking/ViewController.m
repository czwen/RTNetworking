//
//  ViewController.m
//  RTNetworking
//
//  Created by casa on 14-5-6.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import "ViewController.h"
#import "AIFNetworking.h"
#import "TestManager.h"
#import "NSString+AXNetworkingMethods.h"
@interface ViewController ()<RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate>
@property (nonatomic, strong) TestManager *testManager;
@end

@implementation ViewController


#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.testManager loadData];
    NSLog([NSString AX_nonceString32]);
    NSLog([NSString AX_nonceString32]);
    NSLog([NSString AX_nonceString32]);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (TestManager *)testManager
{
    if (!_testManager) {
        _testManager = [[TestManager alloc]init];
        _testManager.delegate = self;
        _testManager.paramSource = self;
    }
    return _testManager;
}


- (NSDictionary *)paramsForApi:(RTAPIBaseManager *)manager
{
    return @{
            @"phone": @"13688893496",
            };
}

- (void)managerCallAPIDidSuccess:(RTAPIBaseManager *)manager
{
    NSDictionary *dic = [manager fetchDataWithReformer:nil];
    
}

- (void)managerCallAPIDidFailed:(RTAPIBaseManager *)manager
{
    
}


@end
