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

}

- (void)setTitleBar {
    
    YLSearchBar *searchBar = [YLSearchBar searchBar];
    searchBar.width = 200;
    searchBar.height = 30;
    searchBar.placeholder = @"请输入";
    self.navigationItem.titleView = searchBar;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)search {
    
    NSLog(@"点击了搜索按钮");
}

@end
