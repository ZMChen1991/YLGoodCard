//
//  YLMineController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLMineController.h"
#import "YLTableViewCell.h"
#import "YLMineHeader.h"
#import "YLDetailController.h"
#import "YLFunctionView.h"
#import "YLSuggestionController.h"
#import "YLLoginController.h"
#import "YLSettingController.h"
#import "YLFunctionController.h"
#import "YLSubController.h"
#import "YLTableGroupHeader.h"
#import "YLAccount.h"
#import "YLAccountTool.h"

@interface YLMineController () <YLFunctionViewDelegate, YLLoginHeaderDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YLMineHeader *header;
@property (nonatomic, strong) YLLoginController *loginVc;

@end

@implementation YLMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
    YLAccount *account = [YLAccountTool account];
    if (account) { // 登录过
        self.header.status = YLLoginStatusUp;
    } else {
        self.header.status = YLLoginStatusDown;
    }

}

- (void)setupNav {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    [self.navigationItem.rightBarButtonItem setImage:[[UIImage imageNamed:@"设置"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
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
    NSLog(@"点击了设置按钮");
    
    YLSettingController *setting = [[YLSettingController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

#pragma mark 代理
- (void)skipToLogin {
    
    NSLog(@"点击了登录按钮");
    self.loginVc = [[YLLoginController alloc] init];
    [self.navigationController pushViewController:self.loginVc animated:YES];
    __weak typeof(self) weakSelf = self;
    self.loginVc.loginBlock = ^(NSString *string) {
        NSLog(@"%@", string);
        weakSelf.header.status = YLLoginStatusUp;
    };
}

- (void)callTelephone {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"13800138000" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    [alert show];
}

- (void)btnClickToController:(UIButton *)sender {
    
    NSLog(@"%@",sender.titleLabel.text);
    NSString *title = sender.titleLabel.text;
    if (sender.tag == 100) {
        NSLog(@"即将看车");
        NSArray *titles = @[@"在售", @"已下架"];
        [self setTitles:titles title:title];

    }
    if (sender.tag == 101) {
        NSLog(@"我的收藏");
        NSArray *titles = @[@"在售", @"已下架"];
        [self setTitles:titles title:title];
    }
    if (sender.tag == 102) {
        NSLog(@"浏览记录");
        NSArray *titles = @[@"在售", @"已下架"];
        [self setTitles:titles title:title];
    }
    if (sender.tag == 103) {
        NSLog(@"我的订阅暂不支持");
    }
    if (sender.tag == 104) {
        NSLog(@"卖车订单");
    }
    if (sender.tag == 105) {
        NSLog(@"买车订单");
    }
    if (sender.tag == 106) {
        NSLog(@"砍价记录");
        YLFunctionController *lookCar = [[YLFunctionController alloc] init];
        lookCar.navigationItem.title = title;
        [self.navigationController pushViewController:lookCar animated:YES];
    }
    if (sender.tag == 107) {
        NSLog(@"降价提醒");
    }
}

- (void)setTitles:(NSArray *)titles title:(NSString *)title {
    
    YLFunctionController *lookCar = [[YLFunctionController alloc] init];
    lookCar.skip.titles = titles;
    NSMutableArray *ctrs = [NSMutableArray array];
    for (NSInteger i = 0; i < titles.count; i++) {
        YLSubController *ctr1 = [[YLSubController alloc] init];
        ctr1.cellType = YLCellTypeNormal;
        [ctrs addObject:ctr1];
    }
    lookCar.skip.controllers = ctrs;
    lookCar.navigationItem.title = title;
    [self.navigationController pushViewController:lookCar animated:YES];
}


- (void)suggestions {
    
    NSLog(@"弹出意见反馈页面");
    YLSuggestionController *suggestionVc = [[YLSuggestionController alloc] init];
    [self.navigationController pushViewController:suggestionVc animated:YES];
}

- (YLMineHeader *)header {
    
    if (!_header) {
        _header = [[YLMineHeader alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 96+88*3)];
        _header.fun.delegate = self;
        _header.loginHeader.delegate = self;
        [self.view addSubview:_header];
    }
    return _header;
}

@end
