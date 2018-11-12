//
//  YLReservationController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
// 预约成功界面

#import "YLReservationController.h"

@interface YLReservationController ()

@end

@implementation YLReservationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我要卖车";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, YLScreenWidth, 100)];
    label.text = @"预约成功";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:30];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}


@end
