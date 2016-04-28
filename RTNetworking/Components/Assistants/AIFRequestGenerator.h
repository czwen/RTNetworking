//
//  AXRequestGenerator.h
//  RTNetworking
//
//  Created by casa on 14-5-14.
//  Copyright (c) 2014年 anjuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIFSignatureProtocol.h"
@interface AIFRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSURLRequest *)generateRequestMethod:(NSString *)method withServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;

@end
