//
//  GRBaseRequest.h
//  GRNetworkDemo
//
//  Created by YiLiFILM on 14/11/25.
//  Copyright (c) 2014年 YiLiFILM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, GRRequestMethod) {
    GRRequestMethodGet = 0,
    GRRequestMethodPost,
};
typedef NS_ENUM(NSInteger, GRRequestSerializerType) {
    GRRequestSerializerTypeJSON = 0,
    GRRequestSerializerTypeHTTP,
};

@interface GRBaseRequest : NSObject

@property (nonatomic, strong) AFHTTPRequestOperation * requestOperation;

//HTTP请求的方法..
@property (nonatomic) GRRequestMethod requestMethod;

//请求的参数
@property (nonatomic, strong) NSDictionary * requestParam;

//服务器地址BaseUrl
@property (nonatomic, strong) NSString * baseUrl;

//请求的URL
@property (nonatomic, strong) NSString * requestUrl;

//返回的数据
@property (nonatomic, strong, readonly) NSString * responseString;

//请求的数据类型
@property (nonatomic) GRRequestSerializerType requestSerializerType;

//失败的回调
@property (nonatomic, copy) void (^failureCompletionBlock)(GRBaseRequest *);

//成功的回调
@property (nonatomic, copy) void (^successCompletionBlock)(GRBaseRequest *);

@property (nonatomic) NSInteger tag;

//状态码校验
- (BOOL)statusCodeValidator;

//把block置nil来打破循环引用
- (void)clearCompletionBlock;

- (void)stop;

@end
