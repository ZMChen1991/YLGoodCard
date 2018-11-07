//
//  YLSearchController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSearchController.h"
#import "YLSearchBar.h"
#import "YLButton.h"
#import "YLTableHeaderView.h"
#import "YLTableHeaderModel.h"

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
    
//    YLButton *btn = [YLButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 200, 150, 30);
//    btn.backgroundColor = [UIColor yellowColor];
//    [btn setTitle:@"查看更多参数配置" forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
//    btn.titleLabel.backgroundColor = [UIColor greenColor];
//    btn.imageView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:btn];
    
    YLTableHeaderModel *model =[[YLTableHeaderModel alloc] init];
    model.title = @"热门二手车";
    model.subtitle = @"查看全部";
//    model.icon = @"";
    
    YLTableHeaderView *view = [[YLTableHeaderView alloc] initWithFrame:CGRectMake(15, 100, self.view.frame.size.width-30, 35)];
//    view.tableHeadertype = YLTableHeaderTypeTitle;
//    view.tableHeadertype = YLTableHeaderTypeImage;
    view.tableHeadertype = YLTableHeaderTypeSubtitle;
//    view.tableHeadertype = YLTableHeaderTypeNone;
    view.tableHeaderModel = model;
//    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
}


@end
