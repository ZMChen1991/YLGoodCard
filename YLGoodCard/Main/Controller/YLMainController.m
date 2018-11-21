//
//  YLMainController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLMainController.h"
#import "YLTitleBar.h"
#import "YLTableViewCell.h"
#import "YLMessageController.h"
#import "YLSearchController.h"
#import "YLDetailController.h"
#import "YLHomeHeader.h"
#import "YLRotateTool.h"
#import "YLTableViewModel.h"
#import "YLBuyController.h"
#import "YLTabBarController.h"

@interface YLMainController ()<UITableViewDelegate, UITableViewDataSource, YLButtonViewDelegate, YLTableGroupHeaderDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *images; // 存放转播图的数组
@property (nonatomic, strong) NSMutableArray *recommends; // 存放推荐类别
@property (nonatomic, strong) NSMutableArray *notableTitles; // 存放走马灯广告
//@property (nonatomic, strong) UIImageView *barImageView; // 导航栏图片背景
@property (nonatomic, strong) YLTabBarController *tabBarVc;

@end

@implementation YLMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO; // 不自动调节滚动区域
//    self.barImageView = self.navigationController.navigationBar.subviews.firstObject;
    [self load];
    [self setNav];
    [self setupTableView];
}

- (void)load {
    
    // 获取轮播图数组
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [YLRotateTool bannerWithParam:param success:^(NSArray<YLBannerModel *> * _Nonnull result) {
        for (YLBannerModel *model in result) {
            [self.images addObject:model.img];
        }
//        NSLog(@"加载数据成功:self.images:%@",self.images);
    } failure:^(NSError * _Nonnull error) {
    }];

    // 获取走马灯广告数组
    [YLRotateTool notableWithParam:param success:^(NSArray<YLNotableModel *> *result) {
        for (YLNotableModel *model in result) {
            [self.notableTitles addObject:model.text];
        }
        NSLog(@"加载走马灯广告成功");
    } failure:^(NSError * _Nonnull error) {
    }];
    // 获取推荐列表数组
    [YLRotateTool recommendWithParam:param success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
        for (YLTableViewModel *model in result) {
            [self.recommends addObject:model];
        }
        [self.tableView reloadData]; // 获取到数据刷新表格
        NSLog(@"加载推荐列表成功");
    } failure:^(NSError * _Nonnull error) {
    }];
}

- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO; // 禁止弹跳
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    NSMutableArray *bannerTitles = [NSMutableArray arrayWithObjects:@"http://image-public.gz.bcebos.com/vehicle.jpg", @"http://image-public.gz.bcebos.com/vehicle2.jpg", @"http://image-public.gz.bcebos.com/vehicle3.jpg", nil];
    CGRect frame = CGRectMake(0, 100, YLScreenWidth, 424);
    YLHomeHeader *homeHeader = [[YLHomeHeader alloc] initWithFrame:frame bannerTitles:bannerTitles notabletitles:self.notableTitles];
    // 代理
//    homeHeader.buttonView.delegate = self;
    homeHeader.groupHeader.delegate = self;
    
    __weak typeof(self) weakSelf = self;
    // block
    homeHeader.buttonView.tapClickBlock = ^(UILabel *label) {
        NSLog(@"YLMainController:%@", label);
        // 点击列表，跳转控制器
        YLSearchController *search = [[YLSearchController alloc] init];
        if (label.tag >= 100  && label.tag < 104) {
            search.price = label.text;
        } else {
            search.brand = label.text;
        }
        search.searchTitle = label.text;
        [weakSelf.navigationController pushViewController:search animated:YES];
    };
    self.tableView.tableHeaderView = homeHeader;
}

#pragma mark UITableViewDataSource/UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  
    return self.recommends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLTableViewCell *cell = [YLTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YLTableViewModel *model = self.recommends[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLTableViewModel *model = self.recommends[indexPath.row];
    YLDetailController *detail = [[YLDetailController alloc] init];
    detail.carID = model.carID;
    NSLog(@"%@", model.carID);
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}


#pragma mark 代理方法
// 这里是条件搜索框里的按钮代理方法，根据标题跳转到搜索框搜索相关的车辆
- (void)selectBtnTitle:(NSString *)title {

    NSLog(@"%@", title);
    YLSearchController *search = [[YLSearchController alloc] init];
    search.searchTitle = title;
    [self.navigationController pushViewController:search animated:YES];
}

- (void)checkMore {
    
    NSLog(@"YLMainController:checkMore");
    YLSearchController *searchVc = [[YLSearchController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}

- (void)pushBuyControl {
    
    // 点击了查看更多
//    self.tabBarVc.selectedIndex = 1;
    YLBuyController *buy = [[YLBuyController alloc] init];
    [self.navigationController pushViewController:buy animated:YES];
}

#pragma mark Private
- (void)setNav {
    
//    // 设置导航栏透明
//    [self.navigationController.navigationBar setTranslucent:YES];
////    // 设置导航栏背景为空
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    // 设置导航栏底部线条为空
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // 添加左右导航栏按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"阳江" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"..." style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
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
    
    // 设置导航栏搜索框按钮
    YLTitleBar *titleBtn = [[YLTitleBar alloc] initWithFrame:CGRectMake(0, 0, 260, 36)];
    [titleBtn setTitle:@"搜索您想要的车" forState:UIControlStateNormal];
    titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    titleBtn.backgroundColor = YLColor(239.f, 242.f, 247.f);
    [titleBtn addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

- (void)titleClick {
    
    NSLog(@"title被点击了！");
    YLSearchController *search = [[YLSearchController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
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

#pragma mark 懒加载
- (NSMutableArray *)recommends {
    
    if (!_recommends) {
        _recommends = [NSMutableArray array];
    }
    return _recommends;
}

- (NSMutableArray *)images {
    
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (NSMutableArray *)notableTitles {
    
    if (!_notableTitles) {
        _notableTitles = [NSMutableArray array];
    }
    return _notableTitles;
}

- (YLTabBarController *)tabBarVc {
    if (!_tabBarVc) {
        _tabBarVc = [[YLTabBarController alloc] init];
    }
    return _tabBarVc;
}
@end
