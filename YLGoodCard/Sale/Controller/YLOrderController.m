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
//#import "YLDetectCenterTool.h"
#import "YLBrandController.h"
#import "YLBrandView.h"
#import "YLSeriesView.h"
#import "YLCartypeView.h"
#import "YLBuyTool.h"

#import "YLSaleTool.h"

@interface YLOrderController () <UITableViewDelegate, UITableViewDataSource, YLConditionDelegate, YLDetectCenterViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *cover; // 蒙板
@property (nonatomic, strong) YLDetectCenterView *detectCenterView;
@property (nonatomic, strong) NSMutableArray *detailArray;
@property (nonatomic, strong) NSMutableArray *brands;

@property (nonatomic, strong) YLBrandView *brandView;
@property (nonatomic, strong) YLSeriesView *seriesView;
@property (nonatomic, strong) YLCartypeView *carTypeView;

@property (nonatomic, strong) YLBrandModel *brandModel;
@property (nonatomic, strong) YLSeriesModel *seriesModel;
@property (nonatomic, strong) YLCarTypeModel *carTypeModel;

@end

@implementation YLOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    [self.cover addSubview:self.brandView];
    [self.cover addSubview:self.seriesView];
    [self.cover addSubview:self.carTypeView];
    [self.view addSubview:self.cover];
}

- (void)loadData {
    
    // 获取检测中心数据
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"阳江" forKey:@"city"];
    [YLSaleTool cityDetectWithParam:param success:^(NSArray * _Nonnull result) {
        NSLog(@"result:%@", result);
        self.detectCenterView.detectCenters = result;
    } failure:nil];
    
    // 获取品牌数据
    NSMutableDictionary *brandParam = [NSMutableDictionary dictionary];
    [YLBuyTool brandWithParam:brandParam success:^(NSArray<YLBrandModel *> * _Nonnull result) {
        // 取出首字母
        NSMutableArray *groups = [NSMutableArray array];
        for (YLBrandModel *model in result) {
            NSString *zimu = model.initialLetter;
            [groups addObject:zimu];
        }
        NSSet *set = [NSSet setWithArray:groups];
        self.brandView.groups = [NSMutableArray arrayWithArray:[set allObjects]];
        // 根据首字母取出汽车品牌
        self.brands = [NSMutableArray array];
        for (NSInteger i = 0; i < self.brandView.groups.count; i++) {
            NSString *str = self.brandView.groups[i];
            NSMutableArray *array = [NSMutableArray array];
            for (YLBrandModel *model in result) {
                if ([str isEqualToString:model.initialLetter]) {
                    [array addObject:model];
                }
            }
            // 将各个首字母汽车品牌存放在数组里
            [self.brands addObject:array];
        }
        self.brandView.brands = self.brands;
    } failure:nil];


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
        self.detectCenterView.hidden = NO;
        self.brandView.hidden = YES;
    }
    if (indexPath.row == 2) {
        NSLog(@"弹出品牌列表");
        self.cover.hidden = NO;
        self.detectCenterView.hidden = YES;
        self.brandView.hidden = NO;
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
        _detailArray = [NSMutableArray arrayWithObjects:@"阳江",@"请选择",@"请选择",@"请输入",@"请输入(单位:万公里)",@"请选择",@"请选择", nil];
    }
    return _detailArray;
}

- (YLDetectCenterView *)detectCenterView {
    
    if (!_detectCenterView) {
        _detectCenterView = [[YLDetectCenterView alloc] initWithFrame:CGRectMake(47, 0, YLScreenWidth - 47, YLScreenHeight-30)];
        _detectCenterView.delegate = self;
        _detectCenterView.hidden = YES;
    }
    return _detectCenterView;
}

- (YLBrandView *)brandView {
    
    if (!_brandView) {
        _brandView = [[YLBrandView alloc] initWithFrame:CGRectMake(50, 50, YLScreenWidth - 100, YLScreenHeight - 300)];
        _brandView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _brandView.BrandViewBlock = ^(YLBrandModel * _Nonnull brandModel) {
            NSLog(@"brandModel:%@", brandModel.brand);
            weakSelf.cover.hidden = NO;
            weakSelf.brandView.hidden = YES;
            weakSelf.seriesView.hidden = NO;
            // 获取车系数据
            NSMutableDictionary *seriesParam = [NSMutableDictionary dictionary];
            [seriesParam setValue:brandModel.brandId forKey:@"id"];
            [YLBuyTool seriesWithParam:seriesParam success:^(NSArray<YLSeriesModel *> * _Nonnull result) {
                weakSelf.seriesView.series = result;
//                weakSelf.seriesView.hidden = NO;
            } failure:nil];
        };
    }
    return _brandView;
}

- (YLSeriesView *)seriesView {
    if (!_seriesView) {
        _seriesView = [[YLSeriesView alloc] initWithFrame:CGRectMake(50, 50, YLScreenWidth - 100, YLScreenHeight - 300)];
        _seriesView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _seriesView.seriesBlock = ^(YLSeriesModel * _Nonnull seriesModel) {
            NSLog(@"%@", seriesModel.series);
            weakSelf.brandView.hidden = YES;
            weakSelf.seriesView.hidden = YES;
            // 获取车型数据
            NSMutableDictionary *carTypeParam = [NSMutableDictionary dictionary];
            [carTypeParam setValue:seriesModel.seriesId forKey:@"id"];
            [YLBuyTool carTypeWithParam:carTypeParam success:^(NSArray<YLCarTypeModel *> * _Nonnull result) {
                NSLog(@"result:%@", result);
                weakSelf.carTypeView.carTypes = (NSMutableArray *)result;
                weakSelf.carTypeView.hidden = NO;
            } failure:nil];
        };
    }
    return _seriesView;
}

- (YLCartypeView *)carTypeView {
    
    if (!_carTypeView) {
        _carTypeView = [[YLCartypeView alloc] initWithFrame:CGRectMake(50, 50, YLScreenWidth - 100, YLScreenHeight - 300)];
        _carTypeView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _carTypeView.carTypeBlock = ^(YLCarTypeModel * _Nonnull carTypeModel) {
            weakSelf.cover.hidden = YES;
            weakSelf.brandView.hidden = NO;
            weakSelf.seriesView.hidden = YES;
            NSLog(@"%@", carTypeModel.ID);
        };
    }
    return _carTypeView;
}

@end
