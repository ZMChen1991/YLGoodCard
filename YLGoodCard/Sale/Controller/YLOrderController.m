//
//  YLOrderController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLOrderController.h"
#import "YLOrderView.h"
#import "YLReservationController.h"

@interface YLOrderController () <UITableViewDelegate, UITableViewDataSource, YLSaleButtonDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;


@end

@implementation YLOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"预约卖车";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    YLOrderView *orderView = [[YLOrderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 130)];
//    orderView.backgroundColor = [UIColor redColor];
    self.tableView.tableFooterView = orderView;
   
    orderView.saleBtn.delegate = self;
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
    cell.detailTextLabel.text = @"请选择";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", self.array[indexPath.row]);
}

#pragma mark YLSaleButtonDelegate
- (void)pushController {
    
    NSLog(@"跳转另一个控制器");
    YLReservationController *reservationVc = [[YLReservationController alloc] init];
    [self.navigationController pushViewController:reservationVc animated:YES];
}

#pragma mark 懒加载
- (NSArray *)array {
    
    if (!_array) {
        _array = [NSArray arrayWithObjects:@"城市", @"检测中心", @"选择车型", @"上牌时间", @"行驶里程", @"验车时间", @"联系电话", nil];
    }
    return _array;
}

@end
