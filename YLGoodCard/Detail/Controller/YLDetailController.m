//
//  YLDetailController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailController.h"
#import "YLDetailFooterView.h"
#import "YLDetailHeaderView.h"
#import "YLSafeguardCell.h"
#import "YLInformationCell.h"
#import "YLCarInformationCell.h"
#import "YLReportCell.h"
#import "YLCondition.h"
#import "YLDetailFooterView.h"
#import "YLCoverView.h"
#import "YLTableGroupHeader.h"

@interface YLDetailController () <UITableViewDelegate, UITableViewDataSource, YLConditionDelegate>

@property (nonatomic, strong) UIImageView *bg;
@property (nonatomic, strong) UIView *labelView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YLCoverView *cover;

@end

@implementation YLDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    [self addTableView];
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YLSafeguardCell *cell = [YLSafeguardCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = YLRandomColor;
        return cell;
    } if (indexPath.section == 1) {
        YLInformationCell *cell = [YLInformationCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = YLRandomColor;
        return cell;
    } if (indexPath.section == 2) {
        YLReportCell *cell = [YLReportCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = YLRandomColor;
        return cell;
    } else {
        YLCarInformationCell *cell = [YLCarInformationCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = YLRandomColor;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CGRect headerRect = CGRectMake(0, 0, YLScreenWidth, 44);
    YLTableGroupHeader *header = [[YLTableGroupHeader alloc] initWithFrame:headerRect image:@"热门二手车" title:@"热门二手车" detailTitle:@"查看更多" arrowImage:@"更多"];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 1.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 160 + YLLeftMargin;
    }
    if (indexPath.section == 1) {
        return 211;
    }
    if (indexPath.section == 2) {
        return 473 + 265 - YLLeftMargin;
    } else {
        return 230;
    }
}

#pragma mark YLConditionDelegate
- (void)bargainPrice {
    
    NSLog(@"bargainPrice");
    self.cover.hidden = NO;
    
}

#pragma mark PrivateMethod
- (void)addTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight - 60) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    YLDetailHeaderView *header = [[YLDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 365)];
    header.bargain.delegate = self;
    self.tableView.tableHeaderView = header;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    YLDetailFooterView *footer = [[YLDetailFooterView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 60, YLScreenWidth, 60)];
    [footer.bargain addTarget:self action:@selector(bargainClick) forControlEvents:UIControlEventTouchUpInside];
    [footer.order addTarget:self action:@selector(orderCarClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:footer];
}

- (void)setupNav {
    
    self.navigationItem.title = @"详情";
    UIBarButtonItem *down = [[UIBarButtonItem alloc] initWithTitle:@"降价通知" style:UIBarButtonItemStylePlain target:self action:@selector(priceDown)];
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItems = @[share, down];
}

- (void)priceDown {
    NSLog(@"降价通知");
}

- (void)share {
    NSLog(@"分享");
}

- (void)bargainClick {
    
    NSLog(@"YLDetailController:点击了砍价");
    self.cover.hidden = NO;
    self.cover.bargainBg.hidden = NO;
    self.cover.orderBg.hidden = YES;
}

- (void)orderCarClick {
    
    NSLog(@"YLDetailController:点击了预约看车");
    self.cover.hidden = NO;
    self.cover.bargainBg.hidden = YES;
    self.cover.orderBg.hidden = NO;
}

#pragma mark 懒加载
- (YLCoverView *)cover {
    
    if (!_cover) {
        _cover = [[YLCoverView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
        _cover.hidden = YES;
        [self.view addSubview:_cover];
    }
    return _cover;
}

- (UIView *)labelView {
    if (!_labelView) {
        CGRect frame = CGRectMake(YLLeftMargin, 64 + YLTopMargin, YLScreenWidth - 2 * YLLeftMargin, 180);
        _labelView = [[UIView alloc] initWithFrame:frame];
        [self.view addSubview:_labelView];
    }
    return _labelView;
}
@end
