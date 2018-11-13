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

@interface YLMineController () <UITableViewDelegate, UITableViewDataSource, YLFunctionViewDelegate, YLLoginHeaderDelegate>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation YLMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    
    YLMineHeader *header = [[YLMineHeader alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 96+88*3)];
    header.fun.delegate = self;
    header.header.delegate = self;

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO; // 禁止弹跳
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = header;
}

- (void)setupNav {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
}


#pragma mark UITableViewDataSource/UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLTableViewCell *cell = [YLTableViewCell cellWithTableView:tableView];
    cell.cellModel = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLDetailController *detailVc = [[YLDetailController alloc] init];
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)rightBarButtonItemClick {
    NSLog(@"消息被点击了");
    
    YLSettingController *setting = [[YLSettingController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

#pragma mark 代理
- (void)skipToLogin {
    
    NSLog(@"点击了登录按钮");
    YLLoginController *loginVc = [[YLLoginController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

- (void)callTelephone {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"13800138000" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    [alert show];
}

- (void)btnClickToController:(UIButton *)sender {
    
    NSLog(@"%@",sender.titleLabel.text);
    
//    NSString *title = sender.titleLabel.text;
    if (sender.tag == 100) {
        NSLog(@"即将看车");
        NSString *title = sender.titleLabel.text;
        YLFunctionController *lookCar = [[YLFunctionController alloc] init];
        NSArray *titles = @[@"在售", @"已下架"];
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
    if (sender.tag == 101) {
        NSLog(@"我的收藏");
        NSString *title = sender.titleLabel.text;
        YLFunctionController *lookCar = [[YLFunctionController alloc] init];
        NSArray *titles = @[@"在售", @"已下架"];
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
    if (sender.tag == 102) {
        NSLog(@"浏览记录");
        NSString *title = sender.titleLabel.text;
        YLFunctionController *lookCar = [[YLFunctionController alloc] init];
        NSArray *titles = @[@"在售", @"已下架"];
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
        NSString *title = sender.titleLabel.text;
        YLFunctionController *lookCar = [[YLFunctionController alloc] init];
        lookCar.navigationItem.title = title;
        [self.navigationController pushViewController:lookCar animated:YES];
    }
    if (sender.tag == 107) {
        NSLog(@"降价提醒");
    }
}

- (void)suggestions {
    
    NSLog(@"弹出意见反馈页面");
    YLSuggestionController *suggestionVc = [[YLSuggestionController alloc] init];
    [self.navigationController pushViewController:suggestionVc animated:YES];
}

@end
