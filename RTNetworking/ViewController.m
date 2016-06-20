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
#import <AFNetworking.h>

@interface ViewController ()<RTAPIManagerApiCallBackDelegate,RTAPIManagerParamSourceDelegate>
@property (nonatomic, strong) TestManager *testManager;
@end

@implementation ViewController


#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.testManager loadData];
    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"eEkctWjYNBOwyjPxwABddY1FTNSOOtDF9h8UYmXDe2XbXSxqibgaJHQNisvbcozX" forHTTPHeaderField:@"token"];
//    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
//    NSURLSessionDataTask *task = [manager POST:@"http:/192.168.11.14:8000/api/v1/profile/avatar" parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:UIImagePNGRepresentation([UIImage imageNamed:@"minion"]) name:@"avatar" fileName:@"img.png" mimeType:@"image/png"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
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
            @"avatar":UIImagePNGRepresentation([UIImage imageNamed:@"minion"])
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
