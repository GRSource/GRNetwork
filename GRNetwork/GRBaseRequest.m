//
//  GRBaseRequest.m
//  GRNetworkDemo
//
//  Created by YiLiFILM on 14/11/25.
//  Copyright (c) 2014年 YiLiFILM. All rights reserved.
//

#import "GRBaseRequest.h"
#import "GRNetworkAgent.h"
@implementation GRBaseRequest

- (NSString *)responseString
{
    return self.requestOperation.responseString;
}
- (BOOL)statusCodeValidator {
    NSInteger statusCode = [self responseStatusCode];
    if (statusCode >= 200 && statusCode <= 299) {
        return YES;
    }else {
        return NO;
    }
}
- (NSInteger)responseStatusCode
{
    return self.requestOperation.response.statusCode;
}
- (void)clearCompletionBlock
{
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}
- (void)stop {
    [[GRNetworkAgent sharedInstance] cancelRequest:self.tag];
}
@end
