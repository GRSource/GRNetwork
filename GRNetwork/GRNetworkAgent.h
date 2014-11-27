//
//  GRNetworkAgent.h
//  GRNetworkDemo
//
//  Created by YiLiFILM on 14/11/25.
//  Copyright (c) 2014年 YiLiFILM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRBaseRequest.h"
#import "AFNetworking.h"
@interface GRNetworkAgent : NSObject

+ (GRNetworkAgent *)sharedInstance;

- (void)requestUrl:(NSString *)url param:(NSDictionary *)requestArgument baseUrl:(NSString *)baseUrl withRequestMethod:(GRRequestMethod)requestMethod withCompletionBlockWithSuccess:(void (^)(GRBaseRequest *))success failure:(void (^)(GRBaseRequest *))failure withTag:(NSInteger)tag;

- (void)addRequest:(GRBaseRequest *)request;
- (void)cancelRequest:(NSInteger)tag;
- (void)cancelAllRequests;
@end
