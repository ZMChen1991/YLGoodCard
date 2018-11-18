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
#import "YLTitleBar.h"
#import "YLTableViewCell.h"
#import "YLLinkageView.h"
#import "YLCustomPrice.h"
#import "YLSelectView.h"
#import "YLSortView.h"
#import "YLRequest.h"
#import "YLRotateTool.h"
#import "YLBrandController.h"

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

@property (nonatomic, strong) YLTitleBar *titleBar;
@property (nonatomic, strong) NSMutableArray *recommends;// 推荐列表或者搜索列表
@property (nonatomic, strong) YLTableViewCell *cell;

@end

@implementation YLBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self load];
    [self setNav];
    [self setUI];
    
    if (![self isBlankString:self.searchTitle]) {
        [self.titleBar setTitle:self.searchTitle forState:UIControlStateNormal];
    }
}

// 加载数据
- (void)load {
    // 获取推荐列表数组
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [YLRotateTool buyWithParam:param success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
        
        for (YLTableViewModel *model in result) {
            [self.recommends addObject:model];
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"大图" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    YLTitleBar *titleBtn = [[YLTitleBar alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [titleBtn setTitle:@"    搜索您想要的车   " forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.backgroundColor = YLColor(239.f, 242.f, 247.f);
    self.navigationItem.titleView = titleBtn;
    self.titleBar = titleBtn;
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
    
    self.coverView.hidden = YES;
    self.sortView.hidden = YES;
    self.customPrice.hidden = YES;
    self.selectView.hidden = YES;
    self.isSelect = NO;
}

- (void)titleClick {
    
    NSLog(@"title被点击了！");
    YLSearchController *searchVc = [[YLSearchController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}

- (void)leftBarButtonItemClick {
    
    NSLog(@"leftBarButtonItem被点击了！");
}

- (void)rightBarButtonItemClick {
    
    NSLog(@"切换大小图显示");
    self.cell.islargeImage = !self.cell.islargeImage;
//    [self.tableView reloadData];
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
            self.coverView.hidden = NO;
            self.sortView.hidden = YES;
            self.customPrice.hidden = YES;
            self.selectView.hidden = NO;
        }
        
    } else {
        self.coverView.hidden = YES;
        self.sortView.hidden = YES;
        self.customPrice.hidden = YES;
        self.selectView.hidden = YES;
    }
}

- (void)pushLowPrice:(NSString *)lowPrice highPrice:(NSString *)highPrice {
    
    self.coverView.hidden = YES;
    self.isSelect = NO;
    // 根据价格视图传过来的低价和高价，重新加载数据，刷新列表
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

    
    self.cell = [YLTableViewCell cellWithTableView:tableView];
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YLTableViewModel *model = self.recommends[indexPath.row];
    self.cell.model = model;
    return self.cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    YLDetailController *detailVc = [[YLDetailController alloc] init];
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 大图：338  小图：110
    if (self.cell.islargeImage) {
        return 338;
    } else {
        return 110;
    }
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

//- (void)tap {
//
//    NSLog(@"点击蒙版");
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//
//    // 如果是子视图，设置无法接受父视图手势
//    if ([touch.view isDescendantOfView:self.sortView]) {
//        return NO;
//    }
//    if ([touch.view isDescendantOfView:self.customPrice]) {
//        return NO;
//    }
//    if ([touch.view isDescendantOfView:self.selectView]) {
//        return NO;
//    }
//    return YES;
//}

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
        self.customPrice.customPriceBlock = ^(NSString *string) {
            NSLog(@"价格视图中的价格按钮被点击点击了%@", string);
            [weakSelf.titleBar setTitle:string forState:UIControlStateNormal];
            weakSelf.coverView.hidden = YES;
            weakSelf.isSelect = NO;
            // 重新加载数据，刷新表格
            
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
@end
