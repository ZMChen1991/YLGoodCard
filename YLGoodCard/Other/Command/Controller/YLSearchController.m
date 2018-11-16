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
#import "YLBrandTool.h"
#import "YLCollectionHeaderView.h"

/**
 搜索界面思路:本地
 1、如果通过首页或者其他界面跳转过来的，将传过来的条件更新到搜索框里，点击搜索按钮，保存条件到文件的第一条
 2、点击搜索框跳转的，在搜索框输入的条件，点击搜索按钮保存到文件里
 历史记录：课通过本地文件获取数据
 */

static NSString *cellID = @"YLSearchCell";
static NSString *HeaderID = @"YLSearchHeader";

@interface YLSearchController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) YLSearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray<NSString *> *searchHistory;// l历史搜索
@property (nonatomic, strong) NSMutableArray *hotSearch;// 热门搜索
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation YLSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitleBar];
    self.searchBar.text = self.searchTitle;

//    // 获取本地存储的搜索记录:只保留6条
//    // 判断文件是否存在
//    NSString *filePath = [self searchHistoryFilePath];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        self.searchHistory = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
//    }
    
    
    [self createCollectionView];
}

#pragma mark 私有方法
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

- (void)createCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 8; // 最小行间距
    //    layout.minimumInteritemSpacing = 5;// 最小item间距
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15); // section的内边距:上左下右
    layout.headerReferenceSize = CGSizeMake(0, 30);// 大概是表头宽是固定不变的
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(100, 32);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    // 注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
    
    // 设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (!self.searchHistory.count) {
        return 1;
    }else {
        return 2;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.searchHistory.count;
    } else {
        return 5;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeaderID forIndexPath:indexPath];
    //添加头视图的内容
    UILabel*titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
    titleLabel.text = @"我是标题";
    //头视图添加view
    [header addSubview:titleLabel];
    return header;
}

#pragma mark 私有方法
- (void)search {
    
    // 获取本地存储的搜索记录:只保留6条
    // 判断文件是否存在
    NSString *filePath = [self searchHistoryFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        self.searchHistory = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }
    // 判断输入的条件是否与之前的相同，如果相同，则删除数组中的再插入到数组的第一位
    NSString *search = self.searchBar.text;
    // 判断是否搜索过
    if ([self.searchHistory containsObject:search]) {
        NSInteger index = [self.searchHistory indexOfObject:search];
        [self.searchHistory removeObjectAtIndex:index];
    }
    [self.searchHistory insertObject:search atIndex:0];
    if (self.searchHistory.count > 6) {
        [self.searchHistory removeLastObject];
    }
    // 更新本地搜索记录
    [self.searchHistory writeToFile:filePath atomically:YES];
    // 清空搜索框
    self.searchBar.text = @"";
    
    [self.collectionView reloadData];
}

// 搜索记录保存路径
- (NSString *)searchHistoryFilePath {
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *string = [filePath stringByAppendingPathComponent:@"searchHistory.plist"];
    return string;
}

#pragma mark 懒加载
- (NSMutableArray<NSString *> *)searchHistory {
    
    if (!_searchHistory) {
        _searchHistory = [NSMutableArray array];
    }
    return _searchHistory;
}

- (NSMutableArray *)hotSearch {
    
    if (!_hotSearch) {
        _hotSearch = [NSMutableArray array];
    }
    return _hotSearch;
}

@end
