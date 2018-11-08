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

@interface YLSearchController ()

@end

@implementation YLSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    YLSearchBar *searchBar = [YLSearchBar searchBar];
    searchBar.width = 200;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;

    YLCondition *btn = [YLCondition buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 50);
    btn.type = YLConditionTypeBlue;
    [btn setTitle:@"热售车" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    YLCondition *btn1 = [YLCondition buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 200, 200, 50);
    btn1.type = YLConditionTypeWhite;
    [btn1 setTitle:@"热卖车" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    
}


@end
