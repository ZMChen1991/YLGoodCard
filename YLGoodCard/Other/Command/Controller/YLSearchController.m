//
//  YLSearchController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSearchController.h"
#import "YLSearchBar.h"
#import "YLHomeHeader.h"


@interface YLSearchController ()

@property (nonatomic, strong) YLSearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *historySearch;// l历史搜索
@property (nonatomic, strong) NSMutableArray *hotSearch;// 热门搜索


@end

@implementation YLSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitleBar];
    self.searchBar.text = self.searchTitle;
}

- (void)setTitleBar {
    
    YLSearchBar *searchBar = [YLSearchBar searchBar];
    searchBar.width = 200;
    searchBar.height = 30;
    searchBar.placeholder = @"请输入";
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = rightBar;
    self.navigationController.navigationBar.backgroundColor = [UIColor lightGrayColor];
}

- (void)search {
    
    NSLog(@"searchTitle:%@",self.searchTitle);
    // 如果搜索框的内容与历史数组中某个内容相同，删除元素，重新插入
    [self.historySearch addObject:self.searchBar.text];
    self.searchBar.text = @"";
    NSLog(@"点击了搜索按钮:%@- %@", self.searchBar.text, self.historySearch);
}

#pragma mark 懒加载
- (NSMutableArray *)historySearch {
    
    if (!_historySearch) {
        _historySearch = [NSMutableArray array];
    }
    return _historySearch;
}

- (NSMutableArray *)hotSearch {
    
    if (!_hotSearch) {
        _hotSearch = [NSMutableArray array];
    }
    return _hotSearch;
}

@end
