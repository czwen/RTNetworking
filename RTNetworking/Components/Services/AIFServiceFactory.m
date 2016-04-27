//
//  AXServiceFactory.m
//  RTNetworking
//
//  Created by casa on 14-5-12.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import "AIFServiceFactory.h"
#import "AIFService.h"

@interface AIFServiceFactory ()

@property (nonatomic, strong) NSCache *serviceStorage;

@end

@implementation AIFServiceFactory

#pragma mark - getters and setters
- (NSCache *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSCache alloc] init];
        _serviceStorage.countLimit = 5; // 我在这里随意定了一个，具体的值还是要取决于各自App的要求。
    }
    return _serviceStorage;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static AIFServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AIFServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (AIFService<AIFServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier
{
    if ([self.serviceStorage objectForKey:identifier] == nil) {
        [self.serviceStorage setObject:[self newServiceWithIdentifier:identifier]
                                forKey:identifier];
    }
    return [self.serviceStorage objectForKey:identifier];
}

#pragma mark - private methods
- (AIFService<AIFServiceProtocal> *)newServiceWithIdentifier:(NSString *)identifier
{
    NSString *serviceClassString = [NSString stringWithFormat:@"AIFService%@", identifier];
    Class serviceClass = NSClassFromString(serviceClassString);
    id service = [[serviceClass alloc] init];
    
    if (service) {
        return service;
    }else{
        return [[AIFService<AIFServiceProtocal> alloc]init];
    }
}

@end
