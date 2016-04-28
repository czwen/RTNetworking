//
//  AIFSignatureProtocol.h
//  RTNetworking
//
//  Created by ChenZhiWen on 16/4/28.
//  Copyright © 2016 anjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AIFSignatureProtocol <NSObject>

- (NSDictionary *)signWithSigParams:(NSDictionary *)allParams methodName:(NSString *)methodName apiVersion:(NSString *)apiVersion privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey;

@end
