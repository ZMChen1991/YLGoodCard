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

@interface YLSaleViewController () <YLConditionDelegate>

@end

@implementation YLSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self setupNav];
    YLSaleView *saleView = [[YLSaleView alloc] init];
    saleView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:saleView];
    
    saleView.saleBtn.delegate = self;
    saleView.consultBtn.delegate = self;
    saleView.appraiseBtn.delegate = self;
}

- (void)setupNav {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"卖车进度" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
}

- (void)rightBarButtonItemClick {
    
    NSLog(@"按钮被点击了...");
    
    
}

#pragma mark YLSaleButton代理方法
- (void)pushController:(UIButton *)sender {
   
    NSLog(@"%@", sender.titleLabel.text);
    YLOrderController *orderVc = [[YLOrderController alloc] init];
    orderVc.navigationItem.title = sender.titleLabel.text;
    [self.navigationController pushViewController:orderVc animated:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self resignFirstResponder];
}

@end
