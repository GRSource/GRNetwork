//
//  GRNetworkAgent.m
//  GRNetworkDemo
//
//  Created by YiLiFILM on 14/11/25.
//  Copyright (c) 2014年 YiLiFILM. All rights reserved.
//

#import "GRNetworkAgent.h"
#import "AFHTTPRequestOperationManager.h"

@implementation GRNetworkAgent {
    AFHTTPRequestOperationManager *_manager;
    NSMutableDictionary * _requestsRecord;
}

+ (GRNetworkAgent *)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (id)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPRequestOperationManager manager];
        _requestsRecord = [NSMutableDictionary dictionary];
        _manager.operationQueue.maxConcurrentOperationCount = 4;
    }
    return self;
}
- (void)addRequest:(GRBaseRequest *)request
{
    GRRequestMethod method = request.requestMethod;
    NSString * url = [NSString stringWithFormat:@"%@%@",request.baseUrl,request.requestUrl];
    NSDictionary * param = request.requestParam;
    if (request.requestSerializerType == GRRequestSerializerTypeHTTP) {
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else if (request.requestSerializerType == GRRequestSerializerTypeJSON) {
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    if (method == GRRequestMethodGet) {
        request.requestOperation = [_manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleRequestResult:operation];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleRequestResult:operation];
        }];
    }else if (method == GRRequestMethodPost) {
        request.requestOperation = [_manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self handleRequestResult:operation];
        }                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self handleRequestResult:operation];
        }];
    }
    [self addOperation:request];
}
- (void)handleRequestResult:(AFHTTPRequestOperation *)operation {
    NSString * key = [self requestHashKey:operation];
    GRBaseRequest *request = _requestsRecord[key];
    if (request) {
        BOOL succeed = [self checkResult:request];
        if (succeed) {
            if (request.successCompletionBlock) {
                request.successCompletionBlock(request);
            }
        }else {
            if (request.failureCompletionBlock) {
                request.failureCompletionBlock(request);
            }
        }
    }
    [self removeOperation:operation];
    [request clearCompletionBlock];
}
- (BOOL)checkResult:(GRBaseRequest *)request
{
    BOOL result = [request statusCodeValidator];
    return result;
}

- (void)addOperation:(GRBaseRequest *)request {
    if (request.requestOperation != nil) {
        NSString * key = [self requestHashKey:request.requestOperation];
        _requestsRecord[key] = request;
    }
}
- (NSString *)requestHashKey:(AFHTTPRequestOperation *)operation
{
    NSString *key = [NSString stringWithFormat:@"%lu", (unsigned long)[operation hash]];
    return key;
}
- (void)removeOperation:(AFHTTPRequestOperation *)operation {
    NSString * key = [self requestHashKey:operation];
    [_requestsRecord removeObjectForKey:key];
}
- (void)requestUrl:(NSString *)url param:(NSDictionary *)requestArgument baseUrl:(NSString *)baseUrl withRequestMethod:(GRRequestMethod)requestMethod withCompletionBlockWithSuccess:(void (^)(GRBaseRequest *))success failure:(void (^)(GRBaseRequest *))failure
{
    GRBaseRequest * base = [[GRBaseRequest alloc] init];
    base.baseUrl = baseUrl;
    base.requestUrl = url;
    base.requestParam = requestArgument;
    base.requestMethod = requestMethod;
    base.successCompletionBlock = success;
    base.failureCompletionBlock = failure;
    base.requestSerializerType = GRRequestSerializerTypeJSON;
    [self addRequest:base];
}
@end
