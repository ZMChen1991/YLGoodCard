//
//  YLMainController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//
/**
 1、轮播图
 2、成交记录
 3、热门品牌
 4、推荐列表
 5、热门品牌点击跳转买车页面
 6、热门头查看更多跳转买车页面
 */



#import "YLMainController.h"
#import "YLTitleBar.h"
#import "YLTableViewCell.h"
#import "YLMessageController.h"
#import "YLSearchController.h"
#import "YLDetailController.h"
#import "YLHomeHeader.h"
//#import "YLRotateTool.h"
#import "YLTableViewModel.h"
#import "YLBuyController.h"
#import "YLTabBarController.h"
#import "YLHomeTool.h"
#import "YLSearchParamModel.h"
#import "YLNavigationController.h"

@interface YLMainController ()<UITableViewDelegate, UITableViewDataSource, YLButtonViewDelegate, YLTableGroupHeaderDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *images; // 存放转播图的数组
@property (nonatomic, strong) NSMutableArray *recommends; // 存放推荐类别
@property (nonatomic, strong) NSMutableArray *notableTitles; // 存放走马灯广告

//@property (nonatomic, strong) YLSearchParamModel *searchParam;
//@property (nonatomic, strong) YLTabBarController *tabBarVc;

@property (nonatomic, strong) NSMutableDictionary *param;

@end

@implementation YLMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO; // 不自动调节滚动区域

    
    [self load];
    [self setNav];
    [self setupTableView];
}

- (void)load {
    
    // 获取轮播图数组
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [YLHomeTool bannerWithParam:param success:^(NSArray<YLBannerModel *> * _Nonnull result) {
        for (YLBannerModel *model in result) {
            [self.images addObject:model.img];
        }
    } failure:nil];
    
    // 获取走马灯广告数组
    [YLHomeTool notableWithParam:param success:^(NSArray<YLNotableModel *> * _Nonnull result) {
        for (YLNotableModel *model in result) {
            [self.notableTitles addObject:model.text];
        }
    } failure:nil];
    
    // 获取推荐列表数组
    [YLHomeTool recommendWithParam:param success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
        for (YLTableViewModel *model in result) {
            [self.recommends addObject:model];
        }
        [self.tableView reloadData]; // 获取到数据刷新表格
    } failure:nil];
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
        NSLog(@"YLMainController:%@", label.text);
        // 点击列表，跳转买车控制器
        YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        YLNavigationController *nav = tab.viewControllers[1];
        YLBuyController *buy = nav.viewControllers.firstObject;
        NSString *labelStr = label.text;
        if ([labelStr isEqualToString:@"5万以下"]) {
            [weakSelf.param setValue:@"0fgf50000" forKey:@"price"];
        } else if ([labelStr isEqualToString:@"5-10万"]) {
            [weakSelf.param setValue:@"50000fgf100000" forKey:@"price"];
        } else if ([labelStr isEqualToString:@"10-15万"]) {
            [weakSelf.param setValue:@"100000fgf150000" forKey:@"price"];
        } else if ([labelStr isEqualToString:@"15万以上"]) {
            [weakSelf.param setValue:@"150000fgf99999999" forKey:@"price"];
        } else {
            [weakSelf.param setValue:labelStr forKey:@"brand"];
        }
        buy.param = weakSelf.param;
        [buy.titleBar setTitle:labelStr forState:UIControlStateNormal];
        tab.selectedIndex = 1;
        [weakSelf.param removeAllObjects];
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
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}


#pragma mark 代理方法
//// 这里是条件搜索框里的按钮代理方法，根据标题跳转到搜索框搜索相关的车辆
//- (void)selectBtnTitle:(NSString *)title {
//
//    NSLog(@"%@", title);
//    YLSearchController *search = [[YLSearchController alloc] init];
//    search.searchTitle = title;
//    [self.navigationController pushViewController:search animated:YES];
//}
//
//// 查看更多
//- (void)checkMore {
//    
//    NSLog(@"YLMainController:checkMore");
//    YLSearchController *searchVc = [[YLSearchController alloc] init];
//    [self.navigationController pushViewController:searchVc animated:YES];
//}

// 点击首页热门二手车的查看更多
- (void)pushBuyControl {
    
    YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    YLNavigationController *nav = tab.viewControllers[1];
    YLBuyController *buy = nav.viewControllers.firstObject;
    [self.param removeAllObjects];
    buy.param = self.param;
    [buy.titleBar setTitle:@"搜索您想要的车" forState:UIControlStateNormal];
    tab.selectedIndex = 1;
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
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [YLHomeTool hotBrandWithParam:param success:^(NSDictionary * _Nonnull result) {
        NSMutableArray *hotBrands = (NSMutableArray *)result[@"data"][@"keyword"];
        YLSearchController *search = [[YLSearchController alloc] init];
        search.hotSearch = hotBrands;
        [self.navigationController pushViewController:search animated:YES];
    } failure:^(NSError * _Nonnull error) {
    }];
    
}


- (void)leftBarButtonItemClick {
    
//    // 获取tabBarVC里的导航控制器存放的子控制器，传值到子控制器，再切换视图
//    YLTabBarController *tab = (YLTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    YLNavigationController *nav2 = tab.viewControllers[1];
//    YLBuyController *buy = nav2.viewControllers.firstObject;
//    buy.searchTitle = @"雪佛兰";
//    tab.selectedIndex = 1;
    
    NSLog(@"leftBarButtonItem被点击了!");
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


- (NSMutableDictionary *)param {
    
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
    }
    return _param;
}

@end
