//
//  YLFunctionBaseController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLFunctionBaseController.h"
#import "YLSwitchView.h"
#import "YLSoldInController.h"
#import "YLSoldOutController.h"
#import "YLSkipView.h"

@interface YLFunctionBaseController ()

@end

@implementation YLFunctionBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *titles = @[@"在售", @"已下架"];
    YLSoldInController *soldInVc = [[YLSoldInController alloc] init];
    YLSoldOutController *soldOutVc = [[YLSoldOutController alloc] init];
    NSArray *controllers = @[soldInVc, soldOutVc];
      
    YLSkipView *skip = [[YLSkipView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth,YLScreenHeight - 64)];
    skip.titles = titles;
    skip.controllers = controllers;
    [self.view addSubview:skip];
}

@end
