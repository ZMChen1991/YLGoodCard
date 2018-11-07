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



#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height

@interface YLMainController ()<UITableViewDelegate, UITableViewDataSource, YLButtonDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YLMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    [self setNav];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -44, YLScreenWidth, YLScreenHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    NSArray *images = @[@"pic_1.jpeg", @"pic_2.jpeg", @"pic_3.jpeg", @"pic_4.jpeg"];
    YLHeaderView *headerView = [[YLHeaderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 344)];
    headerView.pictureRotate.images = images;
    headerView.pictureRotate.timeInterval = 1.0;

    self.tableView.tableHeaderView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    return 141;
}

- (void)checkMore {
    
    NSLog(@"checkMore");
    YLSearchController *searchVc = [[YLSearchController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}

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
    titleBtn.backgroundColor = YLColor(239.f, 242.f, 247.f);
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
