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
#import "YLBrandController.h"

<<<<<<< HEAD
#import "YLBuyTool.h"
#import "YLSaleTool.h"

#import "YLBrandView.h"
#import "YLSeriesView.h"
#import "YLCartypeView.h"
#import "YLCourseView.h"
#import "YLLicenseTime.h"
#import "YLCheckoutView.h"
#import "YLCityView.h"
#import "YLYearMonthPicker.h"
#import "YLAllTimePicker.h"

@interface YLOrderController () <UITableViewDelegate, UITableViewDataSource, YLConditionDelegate, YLDetectCenterViewDelegate>
=======
@interface YLOrderController () <UITableViewDelegate, UITableViewDataSource, YLSaleButtonDelegate>
>>>>>>> parent of 1116516... a

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *cover; // 蒙板
@property (nonatomic, strong) YLDetectCenterView *detectCenterView;
@property (nonatomic, strong) NSMutableArray *detailArray;
@property (nonatomic, strong) NSMutableArray *brands;

@property (nonatomic, strong) YLBrandView *brandView;
@property (nonatomic, strong) YLSeriesView *seriesView;
@property (nonatomic, strong) YLCartypeView *carTypeView;
@property (nonatomic, strong) YLCourseView *courseView;
//@property (nonatomic, strong) YLLicenseTime *licenseTime;
//@property (nonatomic, strong) YLCheckoutView *checkoutView;
@property (nonatomic, strong) YLCityView *cityView;
@property (nonatomic, strong) YLYearMonthPicker *licenseTimeView;
@property (nonatomic, strong) YLAllTimePicker *checkTimeView;


@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *series;
@property (nonatomic, strong) NSString *carType;

// 提交的参数
@property (nonatomic, strong) NSMutableDictionary *param;
@property (nonatomic, strong) YLDetectCenterModel *detectCenterModel;
@property (nonatomic, strong) NSString *checkOut;



@end

@implementation YLOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
<<<<<<< HEAD
    [self setupUI];
    [self loadData];
}

- (void)setupUI {
=======
    self.navigationItem.title = @"预约卖车";
>>>>>>> parent of 1116516... a
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    YLOrderView *orderView = [[YLOrderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 130)];
<<<<<<< HEAD
=======
//    orderView.backgroundColor = [UIColor redColor];
    self.tableView.tableFooterView = orderView;
   
>>>>>>> parent of 1116516... a
    orderView.saleBtn.delegate = self;
    [orderView.saleBtn setTitle:self.navigationItem.title forState:UIControlStateNormal];
    self.tableView.tableFooterView = orderView;
    self.orderView = orderView;
    
    [self.cover addSubview:self.detectCenterView];
    [self.cover addSubview:self.brandView];
    [self.cover addSubview:self.seriesView];
    [self.cover addSubview:self.carTypeView];
    [self.cover addSubview:self.courseView];
    [self.cover addSubview:self.licenseTimeView];
    [self.cover addSubview:self.checkTimeView];
    [self.cover addSubview:self.cityView];
    [self.view addSubview:self.cover];
}

- (void)loadData {
    
    // 获取检测中心数据
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"阳江" forKey:@"city"];
    // 添加参数城市
    [self.param setValue:@"阳江" forKey:@"city"];
    [YLSaleTool cityDetectWithParam:param success:^(NSArray * _Nonnull result) {
//        NSLog(@"result:%@", result);
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
    cell.detailTextLabel.text = self.detailArray[indexPath.row];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
<<<<<<< HEAD
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
        self.checkTimeView.hidden = YES;
        self.licenseTimeView.hidden = YES;
        self.courseView.hidden = YES;
        self.cityView.hidden = YES;
    }
    if (indexPath.row == 2) {
        NSLog(@"弹出品牌列表");
        self.cover.hidden = NO;
        self.detectCenterView.hidden = YES;
        self.brandView.hidden = NO;
        self.checkTimeView.hidden = YES;
        self.licenseTimeView.hidden = YES;
        self.courseView.hidden = YES;
        self.cityView.hidden = YES;
    }
    if (indexPath.row == 3) {
        NSLog(@"填写上牌城市");
        self.cover.hidden = NO;
        self.detectCenterView.hidden = YES;
        self.brandView.hidden = YES;
        self.checkTimeView.hidden = YES;
        self.licenseTimeView.hidden = YES;
        self.courseView.hidden = YES;
        self.cityView.hidden = NO;
    }
    if (indexPath.row == 4) {
        // 弹出时间选择窗口
        self.cover.hidden = NO;
        self.licenseTimeView.hidden = NO;
        self.brandView.hidden = YES;
        self.detectCenterView.hidden = YES;
        self.courseView.hidden = YES;
        self.checkTimeView.hidden = YES;
        self.cityView.hidden = YES;
    }
    if (indexPath.row == 5) {
        // 弹出行驶里程填写窗口
        self.cover.hidden = NO;
        self.courseView.hidden = NO;
        self.licenseTimeView.hidden = YES;
        self.brandView.hidden = YES;
        self.detectCenterView.hidden = YES;
        self.checkTimeView.hidden = YES;
        self.cityView.hidden = YES;
    }
    if (indexPath.row == 6) {
        // 弹出验车时间窗口
        self.cover.hidden = NO;
        self.checkTimeView.hidden = NO;
        self.licenseTimeView.hidden = YES;
        self.brandView.hidden = YES;
        self.detectCenterView.hidden = YES;
        self.courseView.hidden = YES;
        self.cityView.hidden = YES;
    }
    
=======
    NSLog(@"%@", self.array[indexPath.row]);
>>>>>>> parent of 1116516... a
}

#pragma mark YLSaleButtonDelegate
- (void)pushController {
    
    if ([self isFullMessage]) {
        YLReservationController *reservationVc = [[YLReservationController alloc] init];
        // 这里传需要的参数，可以使用数组或字典存放相关的参数
        reservationVc.detectCenterModel = self.detectCenterModel;
        reservationVc.checkOut = self.checkOut;
        
        // 提交卖车信息到后台
        [YLSaleTool saleWithParam:self.param success:^(NSDictionary * _Nonnull result) {
            NSLog(@"%@---%@", self.param, result);
        } failure:nil];
        
        [self.navigationController pushViewController:reservationVc animated:YES];
    } else {
        [self showMessage:@"请输入完整信息"];
    }
    
    
//    NSLog(@"跳转另一个控制器:%@-- %ld", sender.titleLabel.text, sender.tag);
//    NSString *btnTitle = sender.titleLabel.text;
//    if ([btnTitle isEqualToString:@"预约卖车"]) {
//        NSLog(@"跳转到预约卖车界面");
//        YLReservationController *reservationVc = [[YLReservationController alloc] init];
//        // 这里传需要的参数，可以使用数组或字典存放相关的参数
//        reservationVc.detectCenterModel = self.detectCenterModel;
//        reservationVc.checkOut = self.checkOut;
//
//        // 提交卖车信息到后台
//        [self.navigationController pushViewController:reservationVc animated:YES];
//    } else {
//        NSLog(@"跳转到估价界面");
//    }
    
}

- (void)detectCenterClick:(YLDetectCenterModel *)model {
    
    NSLog(@"点击了%@行", model.name);
    self.detectCenterModel = model;
    NSLog(@"%@", self.detectCenterModel.ID);
    // 添加参数检测中心ID
    [self.param setValue:model.ID forKey:@"centerId"];
    [self.detailArray replaceObjectAtIndex:1 withObject:model.name];
    [self.tableView reloadData];
    self.cover.hidden = YES;
}

- (BOOL)isFullMessage {
    
    NSInteger count = self.detailArray.count;
    BOOL isFull = YES;
    for (NSInteger i = 0; i < count; i++) {
        NSString *str = self.detailArray[i];
        if ([str isEqualToString:@"请输入"] || [str isEqualToString:@"请输入(单位:万公里)"] || [str isEqualToString:@"请选择"]) {
            
            isFull = NO;
            break;
        } else {
            isFull = YES;
        }
    }
    return isFull;
}

// 提示弹窗
- (void)showMessage:(NSString *)message {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;// 获取最上层窗口
    
    UILabel *messageLabel = [[UILabel alloc] init];
    CGSize messageSize = CGSizeMake([message getSizeWithFont:[UIFont systemFontOfSize:12]].width + 30, 30);
    messageLabel.frame = CGRectMake((YLScreenWidth - messageSize.width) / 2, YLScreenHeight/2, messageSize.width, messageSize.height);
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = YLColor(233.f, 233.f, 233.f);
    messageLabel.layer.cornerRadius = 5.0f;
    messageLabel.layer.masksToBounds = YES;
    [window addSubview:messageLabel];
    
    [UIView animateWithDuration:1 animations:^{
        messageLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [messageLabel removeFromSuperview];
    }];
}

#pragma mark 懒加载
- (void)setTelephone:(NSString *)telephone {
    _telephone = telephone;
    // 添加参数电话
    [self.param setValue:telephone forKey:@"telephone"];
    [self.detailArray replaceObjectAtIndex:self.detailArray.count-1 withObject:telephone];
}

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
        _detailArray = [NSMutableArray arrayWithObjects:@"阳江",@"请选择",@"请选择",@"请输入",@"请输入",@"请输入(单位:万公里)",@"请输入",@"请选择", nil];
    }
    return _detailArray;
}

- (YLDetectCenterView *)detectCenterView {
    
    if (!_detectCenterView) {
        _detectCenterView = [[YLDetectCenterView alloc] initWithFrame:CGRectMake(47, 0, YLScreenWidth - 47, YLScreenHeight + 20)];
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
//            NSLog(@"brandModel:%@", brandModel.brand);
            weakSelf.brand = brandModel.brand;
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
//            NSLog(@"%@", seriesModel.series);
            weakSelf.series = seriesModel.series;
            weakSelf.brandView.hidden = YES;
            weakSelf.seriesView.hidden = YES;
            // 获取车型数据
            NSMutableDictionary *carTypeParam = [NSMutableDictionary dictionary];
            [carTypeParam setValue:seriesModel.seriesId forKey:@"id"];
            [YLBuyTool carTypeWithParam:carTypeParam success:^(NSArray<YLCarTypeModel *> * _Nonnull result) {
//                NSLog(@"result:%@", result);
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
//            NSLog(@"%@-%@", carTypeModel.name, carTypeModel.ID);
            weakSelf.carType = carTypeModel.name;
            weakSelf.cover.hidden = YES;
            weakSelf.brandView.hidden = NO;
            weakSelf.seriesView.hidden = YES;
            weakSelf.carTypeView.hidden = YES;
            // 添加参数车型ID
            [weakSelf.param setValue:carTypeModel.ID forKey:@"typeId"];
            // 修改detailArray
            NSString *str = [NSString stringWithFormat:@"%@%@%@", weakSelf.brand, weakSelf.series, weakSelf.carType];
            [weakSelf.detailArray replaceObjectAtIndex:2 withObject:str];
            [weakSelf.tableView reloadData];
        };
    }
    return _carTypeView;
}

- (NSMutableDictionary *)param {
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
    }
    return _param;
}

- (YLCourseView *)courseView {
    if (!_courseView) {
        _courseView = [[YLCourseView alloc] initWithFrame:CGRectMake(0, 200, YLScreenWidth, 150)];
        _courseView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _courseView.cancelBlock = ^{
            weakSelf.cover.hidden = YES;
            weakSelf.courseView.hidden = YES;
            [weakSelf.detailArray replaceObjectAtIndex:5 withObject:@"请输入(单位:万公里)"];
            [weakSelf.tableView reloadData];
        };
        _courseView.sureBlock = ^(NSString * _Nonnull course) {
            NSLog(@"%@", course);
            [weakSelf.param setValue:course forKey:@"course"];
            [weakSelf.detailArray replaceObjectAtIndex:5 withObject:course];
            [weakSelf.tableView reloadData];
            weakSelf.cover.hidden = YES;
            weakSelf.courseView.hidden = YES;
        };
    }
    return _courseView;
}

//- (YLLicenseTime *)licenseTime {
//    if (!_licenseTime) {
//        _licenseTime = [[YLLicenseTime alloc] initWithFrame:CGRectMake(0, 200, YLScreenWidth, 150)];
//        _licenseTime.hidden = YES;
//        __weak typeof(self) weakSelf = self;
//        _licenseTime.cancelBlock = ^{
//            weakSelf.cover.hidden = YES;
//            weakSelf.licenseTime.hidden = YES;
//            [weakSelf.detailArray replaceObjectAtIndex:4 withObject:@"请输入"];
//            [weakSelf.tableView reloadData];
//        };
//        _licenseTime.sureBlock = ^(NSString * _Nonnull licenseTime) {
//            NSLog(@"%@", licenseTime);
//            [weakSelf.param setValue:licenseTime forKey:@"licenseTime"];
//            [weakSelf.detailArray replaceObjectAtIndex:4 withObject:licenseTime];
//            [weakSelf.tableView reloadData];
//            weakSelf.cover.hidden = YES;
//            weakSelf.licenseTime.hidden = YES;
//        };
//    }
//    return _licenseTime;
//}

//- (YLCheckoutView *)checkoutView {
//
//    if (!_checkoutView) {
//        _checkoutView = [[YLCheckoutView alloc] initWithFrame:CGRectMake(0, 200, YLScreenWidth, 150)];
//        _checkoutView.hidden = YES;
//        __weak typeof(self) weakSelf = self;
//        _checkoutView.cancelBlock = ^{
//            weakSelf.cover.hidden = YES;
//            weakSelf.checkoutView.hidden = YES;
//            [weakSelf.detailArray replaceObjectAtIndex:6 withObject:@"请输入"];
//            [weakSelf.tableView reloadData];
//        };
//        _checkoutView.sureBlock = ^(NSString * _Nonnull checkOut) {
//            NSLog(@"%@", checkOut);
//            [weakSelf.param setValue:checkOut forKey:@"examineTime"];
//            weakSelf.checkOut = checkOut;
//            [weakSelf.detailArray replaceObjectAtIndex:6 withObject:checkOut];
//            [weakSelf.tableView reloadData];
//            weakSelf.cover.hidden = YES;
//            weakSelf.checkoutView.hidden = YES;
//        };
//    }
//    return _checkoutView;
//}

- (YLAllTimePicker *)checkTimeView {
    if (!_checkTimeView) {
        _checkTimeView = [[YLAllTimePicker alloc] initWithFrame:CGRectMake(0, 200, YLScreenWidth, 150)];
        _checkTimeView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _checkTimeView.cancelBlock = ^{
            weakSelf.cover.hidden = YES;
            weakSelf.checkTimeView.hidden = YES;
            [weakSelf.detailArray replaceObjectAtIndex:6 withObject:@"请输入"];
            [weakSelf.tableView reloadData];
        };
        _checkTimeView.sureBlock = ^(NSString * _Nonnull checkOut) {
            NSLog(@"checkOut :%@", checkOut);
            [weakSelf.param setValue:checkOut forKey:@"examineTime"];
            weakSelf.checkOut = checkOut;
            [weakSelf.detailArray replaceObjectAtIndex:6 withObject:checkOut];
            [weakSelf.tableView reloadData];
            weakSelf.cover.hidden = YES;
            weakSelf.checkTimeView.hidden = YES;
        };
    }
    return _checkTimeView;
}

- (YLYearMonthPicker *)licenseTimeView {
    if (!_licenseTimeView) {
        _licenseTimeView = [[YLYearMonthPicker alloc] initWithFrame:CGRectMake(0, 200, YLScreenWidth, 150)];
        _licenseTimeView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _licenseTimeView.cancelBlock = ^{
            weakSelf.cover.hidden = YES;
            weakSelf.licenseTimeView.hidden = YES;
            [weakSelf.detailArray replaceObjectAtIndex:4 withObject:@"请输入"];
            [weakSelf.tableView reloadData];
        };
        _licenseTimeView.sureBlock = ^(NSString * _Nonnull licenseTime) {
            [weakSelf.param setValue:licenseTime forKey:@"licenseTime"];
            weakSelf.checkOut = licenseTime;
            [weakSelf.detailArray replaceObjectAtIndex:4 withObject:licenseTime];
            [weakSelf.tableView reloadData];
            weakSelf.cover.hidden = YES;
            weakSelf.licenseTimeView.hidden = YES;
        };
    }
    return _licenseTimeView;
}


- (YLCityView *)cityView {
    if (!_cityView) {
        _cityView = [[YLCityView alloc] initWithFrame:CGRectMake(0, 200, YLScreenWidth, 150)];
        _cityView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _cityView.cancelBlock = ^{
            weakSelf.cover.hidden = YES;
            weakSelf.cityView.hidden = YES;
            [weakSelf.detailArray replaceObjectAtIndex:3 withObject:@"请输入(单位:万公里)"];
            [weakSelf.tableView reloadData];
        };
        _cityView.sureBlock = ^(NSString * _Nonnull location) {
            NSLog(@"%@", location);
            [weakSelf.param setValue:location forKey:@"location"];
            [weakSelf.detailArray replaceObjectAtIndex:3 withObject:location];
            [weakSelf.tableView reloadData];
            weakSelf.cover.hidden = YES;
            weakSelf.courseView.hidden = YES;
        };
    }
    return _cityView;
}

@end
