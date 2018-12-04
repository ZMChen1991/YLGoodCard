//
//  YLSearchController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSearchController.h"
#import "YLSearchBar.h"
#import "YLCondition.h"
#import "YLTimePickView.h"
#import "YLSelectView.h"
#import "YLSortView.h"


@interface YLSearchController ()

@end

@implementation YLSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitleBar];
    
//    YLCondition *btn = [YLCondition buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 100, 200, 50);
//    btn.type = YLConditionTypeBlue;
//    [btn setTitle:@"热售车" forState:UIControlStateNormal];
//    [self.view addSubview:btn];
//
//    YLCondition *btn1 = [YLCondition buttonWithType:UIButtonTypeCustom];
//    btn1.frame = CGRectMake(100, 200, 200, 50);
//    btn1.type = YLConditionTypeWhite;
//    [btn1 setTitle:@"热卖车" forState:UIControlStateNormal];
//    [self.view addSubview:btn1];
//
//    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn2.frame = CGRectMake(100, 250, 200, 50);
//    btn2.backgroundColor = [UIColor redColor];
//    [btn2 setTitle:@"热卖" forState:UIControlStateNormal];
//    [self.view addSubview:btn2];
////    // 添加边框
////    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
////    CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){8.0/255.0, 169.0/255.0, 255.0/255.0, 1});
////    [btn2.layer setBorderColor:borderColorRef];
////    [btn2.layer setBorderWidth:2.0];
//
//    YLTimePickView *timePicker = [[YLTimePickView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 213, YLScreenWidth, 213)];
//    [self.view addSubview:timePicker];
    
//    YLSelectView *selectView = [[YLSelectView alloc] initWithFrame:CGRectMake(100, 0, YLScreenWidth-100, YLScreenHeight)];
//    [self.view addSubview:selectView];
    
    YLSortView *sortView = [[YLSortView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
//    sortView.backgroundColor = [UIColor redColor];
    [self.view addSubview:sortView];
}

- (void)setTitleBar {
    
    YLSearchBar *searchBar = [YLSearchBar searchBar];
    searchBar.width = 200;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
}

@end
