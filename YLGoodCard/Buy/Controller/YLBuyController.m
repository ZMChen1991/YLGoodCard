//
//  YLBuyController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBuyController.h"
#import "YLSearchController.h"
#import "YLDetailController.h"
#import "YLBuyTableViewCell.h"
#import "YLLinkageView.h"
#import "YLCustomPrice.h"
#import "YLSelectView.h"
#import "YLSortView.h"
#import "YLRequest.h"
#import "YLRotateTool.h"
#import "YLBrandController.h"
#import "YLBuyCellFrame.h"
#import "YLNoneView.h"
/*
 品牌列表
 */

#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height
#define YLTITLEHEIGHT 35

@interface YLBuyController () <UITableViewDelegate, UITableViewDataSource, YLLinkageViewDelegate, YLSortViewDelegate, UIGestureRecognizerDelegate, YLCustomPriceDelegate>

@property (nonatomic, strong) YLLinkageView *linkageView;// 标题视图
@property (nonatomic, strong) UITableView *tableView;// 数据表
@property (nonatomic, strong) YLSortView *sortView;// 排序视图
@property (nonatomic, strong) YLCustomPrice *customPrice;// 价格视图
@property (nonatomic, strong) YLSelectView *selectView; // 筛选视图
@property (nonatomic, assign) BOOL isSelect;// 是否选中t标题
@property (nonatomic, strong) UIView  *coverView;// 蒙板
@property (nonatomic, assign) BOOL isLarge;// 是否大图模式，默认是NO
@property (nonatomic, strong) YLNoneView *noneView;


@property (nonatomic, strong) NSMutableArray *recommends;// 推荐列表或者搜索列表
@property (nonatomic, strong) NSMutableArray *modelArray;// 存放数据模型的数组
@property (nonatomic, strong) YLBuyTableViewCell *cell;

@end

@implementation YLBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self load];
    [self setNav];
    [self setUI];
    self.isLarge = NO;
    
    if (![self isBlankString:self.searchTitle]) {
        [self.titleBar setTitle:self.searchTitle forState:UIControlStateNormal];
    }
}

// 加载数据
- (void)load {
    // 获取推荐列表数组
    // 这里还需要在修改
#warning 这里逻辑还需要完善！！！
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if ([self.price isEqualToString:@"5万以下"]) {
        param[@"price"] = @"0fgf50000";
    }
    if ([self.price isEqualToString:@"5-10万"]) {
        param[@"price"] = @"50000fgf100000";
    }
    if ([self.price isEqualToString:@"10-15万"]) {
        param[@"price"] = @"100000fgf150000";
    }
    if ([self.price isEqualToString:@"15万以上"]) {
        param[@"price"] = @"150000fgf9999999999";
    }
    param[@"brand"] = self.brand;
    param[@"title"] = self.searchTitle;
    [YLRotateTool buyWithParam:param success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
        
        for (YLTableViewModel *model in result) {
            YLBuyCellFrame *cellFrame = [[YLBuyCellFrame alloc] init];
            cellFrame.model = model;
            [self.modelArray addObject:model];
            [self.recommends addObject:cellFrame];
        }
        NSLog(@"recommend:%lu", self.recommends.count);
        [self.tableView reloadData]; // 获取到数据刷新表格
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

// 加载更多数据
- (void)loadMoreData {
    
}

#pragma mark 私有方法
- (void)setNav {
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"阳江" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    [self.navigationItem.rightBarButtonItem setImage:[[UIImage imageNamed:@"看图模式"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.navigationController.navigationBar setBackgroundColor:YLColor(8.f, 169.f, 255.f)];
    // 设置导航栏背景为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏底部线条为空
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // 修改导航标题
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // 创建一个假状态栏
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, YLScreenWidth, 20)];
    statusBarView.backgroundColor = YLColor(8.f, 169.f, 255.f);
    [self.navigationController.navigationBar addSubview:statusBarView];
    self.navigationItem.titleView = self.titleBar;
}

- (void)setUI {
    
    // 添加标题
    [self.view addSubview:self.linkageView];
    
    // 添加列表
//    float y = CGRectGetMaxY(linkageView.frame)+1;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, YLScreenWidth, YLScreenHeight-100)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    // 添加蒙版
    [self.view addSubview:self.coverView];
    [self.coverView addSubview:self.sortView];
    [self.coverView addSubview:self.customPrice];
    [self.coverView addSubview:self.selectView];
    [self.view addSubview:self.noneView];
    
    self.coverView.hidden = YES;
    self.sortView.hidden = YES;
    self.customPrice.hidden = YES;
    self.selectView.hidden = YES;
    self.isSelect = NO;
}

- (void)titleClick {

//    NSLog(@"title被点击了！");
//    self.coverView.hidden = YES;
//    self.isSelect = NO;
//    YLSearchController *searchVc = [[YLSearchController alloc] init];
//    [self.navigationController pushViewController:searchVc animated:YES];
}

- (void)leftBarButtonItemClick {
    
    NSLog(@"leftBarButtonItem被点击了！");
}

- (void)rightBarButtonItemClick {
    
    NSLog(@"切换大小图显示");
//    NSMutableArray *array = [NSMutableArray arrayWithArray:self.recommends];
    [self.recommends removeAllObjects];
    for (YLTableViewModel *model in self.modelArray) {
        model.isLargeImage = !model.isLargeImage;
        YLBuyCellFrame *cellFrame = [[YLBuyCellFrame alloc] init];
        cellFrame.model = model;
        [self.recommends addObject:cellFrame];
    }
    [self.tableView reloadData];
}

#pragma mark 代理
// 标题按钮点击的代理
- (void)pushCoverView:(UIButton *)sender {

    self.isSelect = !self.isSelect;
    if (self.isSelect) {
        if (sender.tag == 100) {
            NSLog(@"排序");
            self.coverView.hidden = NO;
            self.sortView.hidden = NO;
            self.customPrice.hidden = YES;
            self.selectView.hidden = YES;
        } else if (sender.tag == 101) {
            NSLog(@"品牌");

            self.coverView.hidden = YES;
            self.sortView.hidden = YES;
            self.customPrice.hidden = YES;
            self.selectView.hidden = YES;
            self.isSelect = NO;
            YLBrandController *brand = [[YLBrandController alloc] init];
            [self.navigationController pushViewController:brand animated:YES];

        }else if (sender.tag == 102) {
            NSLog(@"价格");
            self.coverView.hidden = NO;
            self.sortView.hidden = YES;
            self.customPrice.hidden = NO;
            self.selectView.hidden = YES;
        }else {
            NSLog(@"筛选");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此功能以后再开放" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
            self.isSelect = NO;
//            self.coverView.hidden = NO;
//            self.sortView.hidden = YES;
//            self.customPrice.hidden = YES;
//            self.selectView.hidden = NO;
        }

    } else {
        self.coverView.hidden = YES;
        self.sortView.hidden = YES;
        self.customPrice.hidden = YES;
        self.selectView.hidden = YES;
    }
}

// 价格视图里面的高价和低价代理
- (void)pushLowPrice:(NSString *)lowPrice highPrice:(NSString *)highPrice {

    self.coverView.hidden = YES;
    self.isSelect = NO;
    // 根据价格视图传过来的低价和高价，重新加载数据，刷新列表
    NSLog(@"%@--%@", lowPrice, highPrice);
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *tempStr = [NSString stringWithFormat:@"%@fgf%@", lowPrice, highPrice];
    param[@"price"] = tempStr;
    [YLRotateTool buyWithParam:param success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
        [self.recommends removeAllObjects];
        for (YLTableViewModel *model in result) {
            [self.recommends addObject:model];
        }
        NSLog(@"recommend:%lu", self.recommends.count);
        // 如果搜索结果为空，那么显示noneView
        if (![self.recommends count]) {
            self.noneView.hidden = NO;
        }
        [self.tableView reloadData]; // 获取到数据刷新表格
    } failure:^(NSError * _Nonnull error) {

    }];
}

- (void)didSelectSort:(NSString *)string {

//    // 点击了排序，根据排序e内容将数据重新排列
//    // 根据string进行排序，ascending：YES为升序，No为降序
//    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:string ascending:YES];
//    // sortUsingDescriptors后面添加的数组为排序条件组，如果是多个条件排序，先根据最先的条件排序，如果相同，则根据第二个条件进行排序
//    [self.recommends sortUsingDescriptors:@[sort]];
    [self.recommends removeAllObjects];
    if ([string isEqualToString:@"最新上架"]) {
        // 重新请求数据
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"sort"] = @"1";
        // 获取推荐列表数组
        [YLRotateTool buyWithParam:param success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
            [self.recommends removeAllObjects];
            for (YLTableViewModel *model in result) {
                [self.recommends addObject:model];
            }
            [self.tableView reloadData]; // 获取到数据刷新表格
            NSLog(@"请求成功!----%lu", (unsigned long)self.recommends.count);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"请求失败!");
        }];

    }
    if ([string isEqualToString:@"价格最低"]) {

        // 重新请求数据
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"sort"] = @"2";
        // 获取推荐列表数组
        [YLRotateTool buyWithParam:param success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
            [self.recommends removeAllObjects];
            for (YLTableViewModel *model in result) {
                [self.recommends addObject:model];
            }
            [self.tableView reloadData]; // 获取到数据刷新表格
            NSLog(@"请求成功!----%lu", (unsigned long)self.recommends.count);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"请求失败!");
        }];
    }
    if ([string isEqualToString:@"价格最高"]) {

        // 重新请求数据
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"sort"] = @"3";
        // 获取推荐列表数组
        [YLRotateTool buyWithParam:param success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
            [self.recommends removeAllObjects];
            for (YLTableViewModel *model in result) {
                [self.recommends addObject:model];
            }
            [self.tableView reloadData]; // 获取到数据刷新表格
            NSLog(@"请求成功!----%lu", (unsigned long)self.recommends.count);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"请求失败!");
        }];
    }
    if ([string isEqualToString:@"车龄最短"]) {
        // 重新请求数据
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"sort"] = @"4";
        // 获取推荐列表数组
        [YLRotateTool buyWithParam:param success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
            [self.recommends removeAllObjects];
            for (YLTableViewModel *model in result) {
                [self.recommends addObject:model];
            }
            [self.tableView reloadData]; // 获取到数据刷新表格
            NSLog(@"请求成功!----%lu", (unsigned long)self.recommends.count);
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"请求失败!");
        }];
    }
    if ([string isEqualToString:@"里程最少"]) {
        // 重新请求数据
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"sort"] = @"5";
        // 获取推荐列表数组
        [YLRotateTool buyWithParam:param success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
            [self.recommends removeAllObjects];
            for (YLTableViewModel *model in result) {
                [self.recommends addObject:model];
            }
            [self.tableView reloadData]; // 获取到数据刷新表格
            NSLog(@"请求成功!");
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"请求失败!");
        }];
    }
    NSLog(@"YLBuyController:%@", string);
    self.coverView.hidden = YES;
    self.isSelect = NO;
}

#pragma mark UItableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return self.recommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    self.cell = [YLBuyTableViewCell cellWithTableView:tableView];
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cell.cellFrame = self.recommends[indexPath.row];
    return self.cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    YLBuyCellFrame *cellFrame = self.recommends[indexPath.row];
    YLDetailController *detailVc = [[YLDetailController alloc] init];
    detailVc.model = cellFrame.model;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    YLBuyCellFrame *cell = self.recommends[indexPath.row];
    return cell.cellHeight;
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

#pragma mark 懒加载
- (YLLinkageView *)linkageView {
    
    if (!_linkageView) {
        _linkageView = [[YLLinkageView alloc] initWithFrame:CGRectMake(0, 64, YLScreenHeight, YLTITLEHEIGHT)];
        _linkageView.delegate = self;
    }
    return _linkageView;
}

- (YLSortView *)sortView {
    
    if (!_sortView) {
        _sortView = [[YLSortView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
        _sortView.delegate = self;
    }
    return _sortView;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, YLTITLEHEIGHT+65, YLScreenWidth, YLScreenHeight)];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (YLCustomPrice *)customPrice {
    if (!_customPrice) {
        _customPrice = [[YLCustomPrice alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 226)];
        _customPrice.backgroundColor = [UIColor whiteColor];
        _customPrice.delegate = self;
        __weak typeof(self) weakSelf = self;
        self.customPrice.customPriceBlock = ^(UIButton *sender) {
            NSLog(@"价格视图中的价格按钮被点击点击了%@", sender.titleLabel.text);
            [weakSelf.titleBar setTitle:sender.titleLabel.text forState:UIControlStateNormal];
            weakSelf.coverView.hidden = YES;
            weakSelf.isSelect = NO;
            // 重新加载数据，刷新表格
            NSInteger tag = sender.tag - 100;
            NSArray *array = @[@"0fgf9999999", @"0fgf30000", @"30000fgf50000", @"50000fgf70000", @"70000fgf90000", @"90000fgf120000", @"120000fgf160000", @"160000fgf200000", @"200000fgf99999999"];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            param[@"price"] = array[tag];
            [YLRotateTool buyWithParam:param success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
                [weakSelf.recommends removeAllObjects];
                for (YLTableViewModel *model in result) {
                    [weakSelf.recommends addObject:model];
                }
                NSLog(@"recommend:%lu", weakSelf.recommends.count);
                [weakSelf.tableView reloadData]; // 获取到数据刷新表格
            } failure:^(NSError * _Nonnull error) {
                
            }];
            
            [weakSelf.tableView reloadData];
        };
    }
    return _customPrice;
}

- (YLSelectView *)selectView {
    if (!_selectView) {
        _selectView = [[YLSelectView alloc] initWithFrame:CGRectMake(self.coverView.frame.size.width - 328, 0, 328, self.coverView.frame.size.height)];
        _selectView.backgroundColor = [UIColor redColor];
    }
    return _selectView;
}

- (NSMutableArray *)recommends {
    
    if (!_recommends) {
        _recommends = [NSMutableArray array];
    }
    return _recommends;
}

- (YLTitleBar *)titleBar {
    if (!_titleBar) {
        _titleBar = [[YLTitleBar alloc] initWithFrame:CGRectMake(0, 0, 260, 36)];
        [_titleBar setTitle:@"    搜索您想要的车   " forState:UIControlStateNormal];
        [_titleBar addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
        _titleBar.backgroundColor = YLColor(239.f, 242.f, 247.f);
        
    }
    return _titleBar;
}

- (NSMutableArray *)modelArray {
    
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (YLNoneView *)noneView {
    
    if (!_noneView) {
        _noneView = [[YLNoneView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, YLScreenHeight)];
//        _noneView.backgroundColor = [UIColor redColor];
        _noneView.hidden = YES;
    }
    return _noneView;
}

@end
