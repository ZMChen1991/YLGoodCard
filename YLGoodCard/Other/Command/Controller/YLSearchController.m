//
//  YLSearchController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSearchController.h"
#import "YLSearchBar.h"
#import "YLBuyController.h"
#import "YLSearchView.h"

/**
 搜索界面思路:本地
 1、如果通过首页或者其他界面跳转过来的，将传过来的条件更新到搜索框里，点击搜索按钮，保存条件到文件的第一条
 2、点击搜索框跳转的，在搜索框输入的条件，点击搜索按钮保存到文件里
 历史记录：课通过本地文件获取数据
 */

@interface YLSearchController () <UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *searchHistory;// l历史搜索
@property (nonatomic, strong) NSMutableArray *hotSearch;// 热门搜索
@property (nonatomic, strong) YLSearchBar *searchBar;
@property (nonatomic, strong) YLSearchView *searchView;

@end

@implementation YLSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setTitleBar];
    self.searchBar.text = self.searchTitle;
    [self.view addSubview:self.searchView];
}

- (YLSearchView *)searchView {
    
    if (!_searchView) {
        CGRect rect = CGRectMake(0, 64, YLScreenWidth, YLScreenHeight - 64);
        self.searchView = [[YLSearchView alloc] initWithFrame:rect historyArray:self.searchHistory hotArray:self.hotSearch];
        __weak typeof(self) weakSelf = self;
        self.searchView.tapClick = ^(NSString * _Nonnull string) {
            NSLog(@"%@", string);
            weakSelf.searchBar.text = string;
            // 这里跳转到买车控制器
            YLBuyController *buy = [[YLBuyController alloc] init];
            // 将搜索条件传到买车控制器
            buy.searchTitle = string;
            [weakSelf.navigationController pushViewController:buy animated:YES];
        };
    }
    return _searchView;
}

- (NSMutableArray *)hotSearch {
    
    if (!_hotSearch) {
        _hotSearch = [NSMutableArray arrayWithObjects:@"丰田", @"大众", @"日产", @"别克", @"传祺", @"陆风", @"奥迪", @"奔驰", nil];
    }
    return _hotSearch;
}

- (NSMutableArray *)searchHistory {
    
    if (!_searchHistory) {
        _searchHistory = [NSKeyedUnarchiver unarchiveObjectWithFile:YLSearchHistoryPath];
        if (!_searchHistory) {
            _searchHistory = [NSMutableArray array];
        }
    }
    return _searchHistory;
}

- (YLSearchBar *)searchBar {
    
    if (!_searchBar) {
        _searchBar = [[YLSearchBar alloc] init];
    }
    return _searchBar;
}

/**-------------------------------------------------------------*/
#pragma mark 私有方法
- (void)setTitleBar {

    YLSearchBar *searchBar = [YLSearchBar searchBar];
    searchBar.width = 200;
    searchBar.height = 30;
    searchBar.placeholder = @"请搜索您想要的车";
    [searchBar setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;

    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = rightBar;
    self.navigationController.navigationBar.backgroundColor = [UIColor lightGrayColor];
}

#pragma mark 私有方法
- (void)search {

    if (![self isBlankString:self.searchBar.text]) {
        // 跳转m到买车控制器
        YLBuyController *buy = [[YLBuyController alloc] init];
        [self.navigationController pushViewController:buy animated:YES];
        
        // 保存搜索记录
        [self saveSearchHistory:self.searchBar.text];
    } else {
        NSLog(@"搜索栏为空");
    }
}

// 保存历史搜索记录
- (void)saveSearchHistory:(NSString *)search {
    
    // 获取本地存储的搜索记录:只保留6条
    // 判断输入的条件是否与之前的相同，如果相同，则删除数组中的再插入到数组的第一位
    // 判断数组是否已有记录，有则移除再添加
    if ([self.searchHistory containsObject:search]) {
        NSInteger index = [self.searchHistory indexOfObject:search];
        [self.searchHistory removeObjectAtIndex:index];
    }
    [self.searchHistory insertObject:search atIndex:0];
    if (self.searchHistory.count > 6) {
        [self.searchHistory removeLastObject];
    }
//    if ([self isBlankString:self.searchBar.text]) {
//        NSLog(@"退出");
//        return;
//    }
    // 更新本地搜索记录
    //    [self.searchHistory writeToFile:YLSearchHistoryPath atomically:YES];
    BOOL success = [NSKeyedArchiver archiveRootObject:self.searchHistory toFile:YLSearchHistoryPath];
    if (success) {
        NSLog(@"保存成功");
    }
    // 清空搜索框
    self.searchBar.text = @"";
}

// 判断字符串是否为空或者空格符
-  (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
 }


@end
