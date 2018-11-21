//
//  YLOrderController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
// 预约卖车页面

#import "YLOrderController.h"
#import "YLReservationController.h"
#import "YLDetectCenterView.h"
#import "YLDetectCenterTool.h"

@interface YLOrderController () <UITableViewDelegate, UITableViewDataSource, YLConditionDelegate, YLDetectCenterViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *cover; // 蒙板
@property (nonatomic, strong) YLDetectCenterView *detectCenterView;
@property (nonatomic, strong) NSMutableArray *detailArray;

@end

@implementation YLOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.detailArray = [NSMutableArray arrayWithObjects:@"阳江",@"请选择",@"请选择",@"请输入",@"请输入",@"请输入",@"请选择", nil];
    
    [self setupUI];
    [self loadData];
}

- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    YLOrderView *orderView = [[YLOrderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 130)];
    orderView.saleBtn.delegate = self;
    [orderView.saleBtn setTitle:self.navigationItem.title forState:UIControlStateNormal];
    self.tableView.tableFooterView = orderView;
    self.orderView = orderView;
    
    [self.cover addSubview:self.detectCenterView];
    [self.view addSubview:self.cover];
}

- (void)loadData {
    
    // 获取检测中心数据
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [YLDetectCenterTool detectCenterWithParam:param success:^(NSArray<YLDetectCenterModel *> * _Nonnull result) {
        NSLog(@"获取成功");
        self.detectCenterView.detectCenters = result;
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"获取失败");
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    cell.textLabel.text = self.array[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row == self.array.count - 1) {
        cell.detailTextLabel.text = self.telephone;
    } else {
        cell.detailTextLabel.text = self.detailArray[indexPath.row];
    }
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"弹出%@弹窗", self.array[indexPath.row]);
    if (indexPath.row == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂时只支持阳江市" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    if (indexPath.row == 1) {
        NSLog(@"打开弹窗,显示检测中心列表");
        self.cover.hidden = NO;
    }
}

#pragma mark YLSaleButtonDelegate
- (void)pushController:(UIButton *)sender {
    
    NSLog(@"跳转另一个控制器:%@-- %ld", sender.titleLabel.text, sender.tag);
    NSString *btnTitle = sender.titleLabel.text;
    if ([btnTitle isEqualToString:@"预约卖车"]) {
        NSLog(@"跳转到预约卖车界面");
        YLReservationController *reservationVc = [[YLReservationController alloc] init];
        [self.navigationController pushViewController:reservationVc animated:YES];
    } else {
        NSLog(@"跳转到估价界面");
    }
    
}

- (void)detectCenterClick:(YLDetectCenterModel *)model {
    
    NSLog(@"点击了%@行", model.name);
    [self.detailArray replaceObjectAtIndex:1 withObject:model.name];
    [self.tableView reloadData];
    self.cover.hidden = YES;
}

#pragma mark 懒加载
- (NSArray *)array {
    
    if (!_array) {
        _array = [NSArray array];
    }
    return _array;
}

- (UIView *)cover {
    
    if (!_cover) {
        _cover = [[UIView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, YLScreenHeight)];
        _cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _cover.hidden = YES;
    }
    return _cover;
}

- (NSMutableArray *)detailArray {
    if (!_detailArray) {
        _detailArray = [NSMutableArray arrayWithObjects:@"阳江",@"请选择",@"请选择",@"请输入",@"请输入",@"请输入",@"请选择", nil];
    }
    return _detailArray;
}

- (YLDetectCenterView *)detectCenterView {
    
    if (!_detectCenterView) {
        _detectCenterView = [[YLDetectCenterView alloc] initWithFrame:CGRectMake(47, 0, YLScreenWidth - 47, YLScreenHeight+20)];
        _detectCenterView.delegate = self;
    }
    return _detectCenterView;
}

@end
