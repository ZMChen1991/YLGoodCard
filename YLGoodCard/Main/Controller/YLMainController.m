//
//  YLMainController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLMainController.h"
#import "YLTitleBar.h"
#import "PictureRotate.h"
#import "YLTableViewCell.h"
#import "YLHeaderView.h"
#import "YLMessageController.h"
#import "YLSearchController.h"
#import "YLDetailController.h"
#import "YLButton.h"

#import "YLRequest.h"

/* 搜索页面，广告轮播
 */

#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height

@interface YLMainController ()<UITableViewDelegate, UITableViewDataSource, YLButtonDelegate, YLHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YLMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO; // 不自动调节滚动区域
    
    [self setNav];
    [self setupTableView];
    [self load];
}

- (void)load {
    
    NSString *str = @"http://ucarjava.bceapp.com/play?method=play";
    [YLRequest GET:str parameters:nil responseCache:nil success:^(id  _Nonnull responseObject) {
        NSLog(@"获取成功:%@", responseObject);
        NSArray *data = responseObject[@"data"];
        NSLog(@"data:%@",data);
    } failed:^(NSError * _Nonnull error) {
        NSLog(@"获取失败");
    }];
}


- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -44, YLScreenWidth, YLScreenHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO; // 禁止弹跳
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSArray *images = @[@"pic_1.jpeg", @"pic_2.jpeg", @"pic_3.jpeg", @"pic_4.jpeg"];
    YLHeaderView *headerView = [[YLHeaderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 344)];
    headerView.pictureRotate.images = images;
    headerView.pictureRotate.timeInterval = 1.0;
    headerView.menuView.subTitle.delegate = self;
    headerView.delegate = self;
    self.tableView.tableHeaderView = headerView;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLDetailController *detailVc = [[YLDetailController alloc] init];
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}


#pragma mark 代理方法
- (void)choiceBrand:(UIButton *)sender {
    
    NSLog(@"YLMainController:%@", sender.titleLabel.text);
}

- (void)checkMore {
    
    NSLog(@"YLMainController:checkMore");
    YLSearchController *searchVc = [[YLSearchController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}

#pragma mark Private
- (void)setNav {
    
    // 设置导航栏透明
    [self.navigationController.navigationBar setTranslucent:YES];
    // 设置导航栏背景为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏底部线条为空
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    // 添加左右导航栏按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"阳江" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"..." style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    // 设置导航栏搜索框按钮
    YLTitleBar *titleBtn = [[YLTitleBar alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [titleBtn setTitle:@"    搜索您想要的车   " forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

- (void)titleClick {
    
    NSLog(@"title被点击了！");
    
    YLSearchController *searchVc = [[YLSearchController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
    
}

- (void)leftBarButtonItemClick {
    
    NSLog(@"leftBarButtonItem被点击了！");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂时只支持阳江市" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)rightBarButtonItemClick {
    
    NSLog(@"消息中心被点击了！");
    YLMessageController *messageVc = [[YLMessageController alloc] init];
    [self.navigationController pushViewController:messageVc animated:YES];
}
@end
