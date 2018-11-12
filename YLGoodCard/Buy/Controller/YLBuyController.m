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

/*
 品牌列表
 */

#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height
#define YLTITLEHEIGHT 35

@interface YLBuyController () <UITableViewDelegate, UITableViewDataSource, YLLinkageViewDelegate, YLSortViewDelegate>

@property (nonatomic, strong) YLLinkageView *linkageView;// 联动标题
@property (nonatomic, strong) UITableView *tableView;// 数据表
@property (nonatomic, strong) YLSortView *sortView;// 排序表
@property (nonatomic, strong) YLCustomPrice *customPrice;// 价格表
@property (nonatomic, strong) YLSelectView *selectView; // 筛选表
@property (nonatomic, assign) BOOL isSelect;// 是否选中
@property (nonatomic, strong) UIView  *coverView;// 蒙板

@end

@implementation YLBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setUI];
}

#pragma mark 私有方法
- (void)setNav {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"阳江" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    YLTitleBar *titleBtn = [[YLTitleBar alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [titleBtn setTitle:@"    搜索您想要的车   " forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.backgroundColor = YLColor(239.f, 242.f, 247.f);
    self.navigationItem.titleView = titleBtn;
}

- (void)setUI {
    
    // 添加标题
    [self.view addSubview:self.linkageView];
    
    // 添加列表
//    float y = CGRectGetMaxY(linkageView.frame)+1;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, YLScreenWidth, YLScreenHeight)];
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
    
}

#pragma mark 代理
- (void)pushCoverView:(UIButton *)sender {
    
    self.isSelect = !self.isSelect;
    if (self.isSelect) {
        switch (sender.tag) {
            case 100:
                NSLog(@"排序");
                self.coverView.hidden = NO;
                self.sortView.hidden = NO;
                self.customPrice.hidden = YES;
                self.selectView.hidden = YES;
                break;
            case 101:
                NSLog(@"品牌");
                self.coverView.hidden = YES;
                self.sortView.hidden = YES;
                self.customPrice.hidden = YES;
                self.selectView.hidden = YES;
                self.isSelect = NO;
                break;
            case 102:
                NSLog(@"价格");
                self.coverView.hidden = NO;
                self.sortView.hidden = YES;
                self.customPrice.hidden = NO;
                self.selectView.hidden = YES;
                break;
            case 103:
                NSLog(@"筛选");
                self.coverView.hidden = NO;
                self.sortView.hidden = YES;
                self.customPrice.hidden = YES;
                self.selectView.hidden = NO;
                break;
            default:
                break;
        }
    } else {
        self.coverView.hidden = YES;
        self.sortView.hidden = YES;
        self.customPrice.hidden = YES;
        self.selectView.hidden = YES;
    }
}

- (void)didSelectSort:(NSString *)string {
    
    NSLog(@"YLBuyController:%@", string);
    self.coverView.hidden = YES;
    self.isSelect = NO;
}

#pragma mark UItableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        YLTableViewCell *cell = [YLTableViewCell cellWithTableView:tableView];
        cell.cellModel = nil;
        cell.type = YLTableViewCellTypeSmallImage;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    YLDetailController *detailVc = [[YLDetailController alloc] init];
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

        return 110; // 大图：338  小图：110
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
    }
    return _coverView;
}

- (YLCustomPrice *)customPrice {
    if (!_customPrice) {
        _customPrice = [[YLCustomPrice alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 226)];
        _customPrice.backgroundColor = [UIColor whiteColor];
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
@end
