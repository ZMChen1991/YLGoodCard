//
//  YLSaleViewController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSaleViewController.h"
#import "YLSaleView.h"
#import "YLOrderController.h"
#import "YLSalerInformation.h"

@interface YLSaleViewController () <YLConditionDelegate>

@property (nonatomic, strong) YLSaleView *saleView;

@end

@implementation YLSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
    YLSaleView *saleView = [[YLSaleView alloc] init];
    saleView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:saleView];
    self.saleView = saleView;
    
    saleView.saleBtn.delegate = self;
    saleView.consultBtn.delegate = self;
    saleView.appraiseBtn.delegate = self;
}

- (void)setupNav {
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"卖车进度" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
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
}

- (void)rightBarButtonItemClick {
    
    NSLog(@"按钮被点击了...");
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂时只支持阳江市" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//    [alert show];
}

#pragma mark YLSaleButton代理方法
- (void)pushController:(UIButton *)sender {
    
    NSLog(@"%@---%ld", sender.titleLabel.text, sender.tag);
    NSString *title = sender.titleLabel.text;
    NSInteger index = sender.tag;
    __weak typeof(self) weakSelf = self;
    if (index == 101) {
        if ([NSString isBlankString:self.saleView.telephone.text]) {
            // 如果电话号码为空，点击按钮弹出提示框
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入电话号码" message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            self.saleView.saleTelBlock = ^(NSString *telString) {
                NSLog(@"预约卖车电话：%@", telString);
                NSArray *titles = @[@"城市", @"检测中心", @"选择车型", @"上牌时间", @"行驶里程", @"验车时间", @"联系电话"];
                YLOrderController *orderVc = [[YLOrderController alloc] init];
                orderVc.array = titles;
                orderVc.telephone = telString;
                orderVc.navigationItem.title = title;
                [weakSelf.navigationController pushViewController:orderVc animated:YES];
                // 保存用户信息
                YLSalerInformation *saler = [YLSalerInformation saler];
                saler.telephone = telString;
                [YLSalerInformation saveInformation:saler];
            };
        }
    }
    if (index == 102) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"联系电话"
                                                        message:@"0662-12345678"
                                                       delegate:nil
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    if (index == 103) {
//        if ([NSString isBlankString:self.saleView.telephone.text]) {
            // 如果电话号码为空，点击按钮弹出提示框
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"此功能以后开放"
                                                           delegate:nil
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil, nil];
            [alert show];
//        } else {
//            self.saleView.saleTelBlock = ^(NSString *telString) {
//                NSLog(@"预约估价电话：%@", telString);
//                NSArray *titles = @[@"选择车型", @"上牌城市", @"上牌时间", @"行驶里程", @"验车时间", @"联系电话"];
//                YLOrderController *orderVc = [[YLOrderController alloc] init];
//                orderVc.array = titles;
//                orderVc.telephone = telString;
//                orderVc.navigationItem.title = title;
//                [weakSelf.navigationController pushViewController:orderVc animated:YES];
//            };
//        }
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self resignFirstResponder];
}

@end
