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

/* 搜索页面，广告轮播
 */

#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height

@interface YLMainController ()<UITableViewDelegate, UITableViewDataSource, YLButtonViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *images; // 存放转播图的数组
@property (nonatomic, strong) NSMutableArray *recommends; // 存放推荐类别
@property (nonatomic, strong) NSMutableArray *notableTitles; // 存放走马灯广告
@property (nonatomic, strong) UIImageView *barImageView;

@property (nonatomic, strong) YLSearchController *searchVc;
//@property (nonatomic, strong) YLTableViewModel *tableViewModel;

@end

@implementation YLMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO; // 不自动调节滚动区域
    self.barImageView = self.navigationController.navigationBar.subviews.firstObject;
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
        NSLog(@"%@",self.notableTitles);
    } failure:^(NSError * _Nonnull error) {
        
    }];
    // 获取推荐列表数组
    [YLRotateTool recommendWithParam:nil success:^(NSArray<YLTableViewModel *> * _Nonnull result) {
        
        for (YLTableViewModel *model in result) {
            [self.recommends addObject:model];
        }
        NSLog(@"recommend:%@", self.recommends);
        [self.tableView reloadData]; // 获取到数据刷新表格
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, YLScreenWidth, YLScreenHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO; // 禁止弹跳
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    NSMutableArray *bannerTitles = [NSMutableArray arrayWithObjects:@"http://image-public.gz.bcebos.com/vehicle.jpg", @"http://image-public.gz.bcebos.com/vehicle2.jpg", @"http://image-public.gz.bcebos.com/vehicle3.jpg", nil];
//    [self.images addObjectsFromArray:bannerTitles];
//    NSMutableArray *notabletitles = [NSMutableArray arrayWithObjects:@"恭喜李先生138001shgfb成功生138001shgfb成功购购买了丰田一台", @"恭喜李先生13800138000以8万成功购买了丰田一台", @"恭喜李先生1380124345以生138001shgfb成功购8万成功购买了丰田一台", @"恭喜4567677756asdas00以8万成功生138001shgfb成功购购买了丰田一台", @"恭喜ddht生13生138001shgfb成功购800156dh00以8万成功购买了丰田一台", nil];
//    NSLog(@"%@",self.images);
    CGRect frame = CGRectMake(0, 100, YLScreenWidth, 424);
    YLHomeHeader *homeHeader = [[YLHomeHeader alloc] initWithFrame:frame bannerTitles:bannerTitles notabletitles:self.notableTitles];
    homeHeader.buttonView.delegate = self;
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
//    //----------假数据-------------//
//    YLTableViewModel *model = [[YLTableViewModel alloc] init];
//    model.title = @"丰田 卡罗拉 2017款 改款双擎 1.8LE-CVT领先版";
//    model.course = @"2012年/12.8万公里";
//    model.price = @"10.6万";
//    model.originalPrice = @"新车价18.8万";
//    model.downPrice = @"比原价下降了3万";
//    model.bargain = @"10";
//    model.type = YLTableViewCellTypeSamllImage;
    //    model.type = YLCellTypeLargeImage;
    //    model.status = YLCellStatusSold;
//    model.status = YLTableViewCellStatusBargain;
//    model.status = YLTableViewCellStatusDownPrice;
//    model.status = YLTableViewCellStatusSold;
    //-----------------------//
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    YLTableViewModel *model = self.recommends[indexPath.row];
    cell.model = model;
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
- (void)selectBtnTitle:(NSString *)title {

    NSLog(@"YLButtonViewDelegate:%@", title);
    self.searchVc.searchTitle = title;
    NSLog(@"YLButtonViewDelegate:%@--%@", title, self.searchVc.searchTitle);
    [self.navigationController pushViewController:self.searchVc animated:YES];
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
    
    self.barImageView.alpha = 0;
    
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
    [self.navigationController pushViewController:self.searchVc animated:YES];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offset = scrollView.contentOffset.y;
//    NSLog(@"%f", offset);
    CGFloat minAlphaOffset = -64;
    CGFloat maxAlphaOffset = 72;
    CGFloat alpha = (offset - minAlphaOffset)/(maxAlphaOffset - minAlphaOffset);
    self.barImageView.alpha = alpha;
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

- (YLSearchController *)searchVc {
    
    if (!_searchVc) {
        _searchVc = [[YLSearchController alloc] init];
    }
    return _searchVc;
}
@end
