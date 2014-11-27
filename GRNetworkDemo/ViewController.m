//
//  ViewController.m
//  GRNetworkDemo
//
//  Created by YiLiFILM on 14/11/25.
//  Copyright (c) 2014年 YiLiFILM. All rights reserved.
//

#import "ViewController.h"
#import "GRNetworkAgent.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[GRNetworkAgent sharedInstance] requestUrl:@"/pps/s.py?pg=c&gd=22&cd=48261&type=ios" param:nil baseUrl:@"http://int.m.joy.cn" withRequestMethod:GRRequestMethodGet withCompletionBlockWithSuccess:^(GRBaseRequest * request) {
        NSLog(@"success: %@",request.responseString);
        
    } failure:^(GRBaseRequest * request) {
        NSLog(@"failure: %@",request.responseString);
    } withTag:101];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
