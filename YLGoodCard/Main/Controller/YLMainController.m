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

@interface YLMainController ()<UITableViewDelegate, UITableViewDataSource, YLButtonViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *images; // 存放转播图的数组
@property (nonatomic, strong) NSMutableArray *recommends; // 存放推荐类别
@property (nonatomic, strong) NSMutableArray *notableTitles; // 存放走马灯广告
//@property (nonatomic, strong) UIImageView *barImageView; // 导航栏图片背景

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
    [YLRotateTool bannerWithParam:nil success:^(NSArray<YLBannerModel *> * _Nonnull result) {
        for (YLBannerModel *model in result) {
            [self.images addObject:model.img];
        }
        NSLog(@"self.images:%@",self.images);
    } failure:^(NSError * _Nonnull error) {
    }];

    // 获取走马灯广告数组
    [YLRotateTool notableWithParam:nil success:^(NSArray<YLNotableModel *> *result) {
        for (YLNotableModel *model in result) {
            [self.notableTitles addObject:model.text];
        }
    } failure:^(NSError * _Nonnull error) {
    }];
    // 获取推荐列表数组
    [YLRotateTool recommendWithParam:nil success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
        for (YLTableViewModel *model in result) {
            [self.recommends addObject:model];
        }
        [self.tableView reloadData]; // 获取到数据刷新表格
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
    
    // block
    homeHeader.buttonView.tapClickBlock = ^(NSString * _Nonnull string) {
        NSLog(@"YLMainController:%@", string);
        // 点击列表，跳转控制器
        YLSearchController *search = [[YLSearchController alloc] init];
        search.searchTitle = string;
        [self.navigationController pushViewController:search animated:YES];
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
    
    YLDetailController *detail = [[YLDetailController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}


#pragma mark 代理方法
// 这里是条件搜索框里的按钮代理方法，根据标题跳转到搜索框搜索相关的车辆
- (void)selectBtnTitle:(NSString *)title {

    YLSearchController *search = [[YLSearchController alloc] init];
    search.searchTitle = title;
    [self.navigationController pushViewController:search animated:YES];
}

- (void)checkMore {
    
    NSLog(@"YLMainController:checkMore");
    YLSearchController *searchVc = [[YLSearchController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}

#pragma mark Private
- (void)setNav {
    
//    // 设置导航栏透明
//    [self.navigationController.navigationBar setTranslucent:YES];
////    // 设置导航栏背景为空
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    // 设置导航栏底部线条为空
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
//    self.barImageView.alpha = 0;
    
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

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    CGFloat offset = scrollView.contentOffset.y;
//    CGFloat minAlphaOffset = -64;
//    CGFloat maxAlphaOffset = 72;
//    CGFloat alpha = (offset - minAlphaOffset)/(maxAlphaOffset - minAlphaOffset);
//    self.barImageView.alpha = alpha;
//}

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
@end
