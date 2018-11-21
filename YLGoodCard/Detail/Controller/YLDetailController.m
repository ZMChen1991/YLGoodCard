//
//  YLDetailController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailController.h"
#import "YLDetailFooterView.h"
#import "YLDetailHeaderView.h"
#import "YLSafeguardCell.h"
#import "YLInformationCell.h"
#import "YLCarInformationCell.h"
#import "YLReportCell.h"
#import "YLCondition.h"
#import "YLDetailFooterView.h"
#import "YLCoverView.h"
#import "YLTableGroupHeader.h"
#import "YLDetailTool.h"
#import "YLDetailModel.h"
#import "YLDetailHeaderModel.h"
#import "YLDetailInfoModel.h"
#import "YLDetailHeaderModel.h"
#import "YLConfigController.h"
#import "YLLoginController.h"
#import "YLAccount.h"
#import "YLAccountTool.h"

@interface YLDetailController () <UITableViewDelegate, UITableViewDataSource, YLConditionDelegate>

@property (nonatomic, strong) UIImageView *bg;
@property (nonatomic, strong) UIView *labelView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YLCoverView *cover;
@property (nonatomic, strong) YLDetailModel *detailModel;
@property (nonatomic, strong) YLDetailHeaderView *header;


@end

@implementation YLDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self setupNav];
    [self addTableView];
    
}

- (void)loadData {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = self.carID;
    __weak typeof(self) weakSelf = self;
    [YLDetailTool detailWithParam:param success:^(YLDetailModel *result) {
        self.detailModel = result;
//        YLDetailHeaderModel *headerModel = [YLDetailHeaderModel mj_objectWithKeyValues:self.detailModel];
//        NSLog(@"%@---%@--", result, headerModel);
        YLDetailHeaderModel *headerModel = [YLDetailHeaderModel mj_objectWithKeyValues:weakSelf.detailModel];
        weakSelf.header.model = headerModel;
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {

    }];
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YLSafeguardCell *cell = [YLSafeguardCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } if (indexPath.section == 1) {
        YLInformationCell *cell = [YLInformationCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        YLDetailInfoModel *infoModel = [YLDetailInfoModel mj_objectWithKeyValues:self.detailModel];
        if (infoModel) {
            cell.model = infoModel;
        }
        return cell;
    } if (indexPath.section == 2) {
        YLReportCell *cell = [YLReportCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        YLCarInformationCell *cell = [YLCarInformationCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CGRect headerRect = CGRectMake(0, 0, YLScreenWidth, 44);
    NSArray *titles = @[@"服务保障",@"基本信息",@"检测报告",@"车辆图文"];
    NSArray *images = @[@"服务保障", @"基本信息", @"检测报告", @"车辆图文"];
    NSArray *details = @[@"", @"查看更多配置", @"", @""];
    YLTableGroupHeader *header = [[YLTableGroupHeader alloc] initWithFrame:headerRect image:images[section] title:titles[section] detailTitle:details[section] arrowImage:@"更多"];
    header.labelBlock = ^(NSString * _Nonnull string) {
        NSLog(@"string:%@",string);
        BOOL success = [string isEqualToString:@"查看更多配置1"];
        NSLog(@"success:%d", success);
        if ([string isEqualToString:@"查看更多配置"]) {
            NSLog(@"跳转更多配置界面");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此功能以后开放" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
//            YLConfigController *config = [[YLConfigController alloc] init];
//            config.carID = self.carID;
//            [self.navigationController pushViewController:config animated:YES];
        }
//        if ([string isEqualToString:@"查看详细检测报告"]) {
//            NSLog(@"跳转查看详细检测报告界面");
//        }
    };
    header.backgroundColor = [UIColor whiteColor];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 1.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 160 + YLLeftMargin;
    }
    if (indexPath.section == 1) {
        return 211;
    }
    if (indexPath.section == 2) {
        return 473 + 1;
    } else {
        return 230;
    }
}

#pragma mark YLConditionDelegate
//- (void)bargainPrice {
//
//    NSLog(@"bargainPrice");
//    self.cover.hidden = NO;
//
//}

#pragma mark PrivateMethod
- (void)addTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight - 60) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    YLDetailHeaderView *header = [[YLDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 365)];
    header.bargain.delegate = self;
    self.tableView.tableHeaderView = header;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.header = header;
    
    YLDetailFooterView *footer = [[YLDetailFooterView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 60, YLScreenWidth, 60)];
    footer.detailFooterBlock = ^(UIButton *sender) {
        // 判断用户是否登录，如果没有登录，则跳转到登录界面登录
        if (sender.tag == 101) {
            YLAccount *account = [YLAccountTool account];
            if (account) {
                [sender setImage:[UIImage imageNamed:@"已收藏"] forState:UIControlStateNormal];
                [self showMessage:@"已收藏"];
            } else {
                YLLoginController *login = [[YLLoginController alloc] init];
                [self.navigationController pushViewController:login animated:YES];
            }
            
        }
        if (sender.tag == 102) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"联系方式" message:@"0662-88888888" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    };
    [footer.bargain addTarget:self action:@selector(bargainClick) forControlEvents:UIControlEventTouchUpInside];
    [footer.order addTarget:self action:@selector(orderCarClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:footer];
}

- (void)setupNav {
    
//    self.navigationItem.title = @"详情";
//    UIBarButtonItem *down = [[UIBarButtonItem alloc] initWithTitle:@"降价通知" style:UIBarButtonItemStylePlain target:self action:@selector(priceDown)];
//    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
//    self.navigationItem.rightBarButtonItems = @[share, down];
}

- (void)priceDown {
    NSLog(@"降价通知");
}

- (void)share {
    NSLog(@"分享");
}

- (void)bargainClick {
    
    NSLog(@"YLDetailController:点击了砍价");
    self.cover.hidden = NO;
    self.cover.bargainBg.hidden = NO;
    self.cover.orderBg.hidden = YES;
}

- (void)orderCarClick {
    
    NSLog(@"YLDetailController:点击了预约看车");
    self.cover.hidden = NO;
    self.cover.bargainBg.hidden = YES;
    self.cover.orderBg.hidden = NO;
}

#pragma mark 懒加载
- (YLCoverView *)cover {
    
    if (!_cover) {
        _cover = [[YLCoverView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
        _cover.hidden = YES;
        [self.view addSubview:_cover];
    }
    return _cover;
}

- (UIView *)labelView {
    if (!_labelView) {
        CGRect frame = CGRectMake(YLLeftMargin, 64 + YLTopMargin, YLScreenWidth - 2 * YLLeftMargin, 180);
        _labelView = [[UIView alloc] initWithFrame:frame];
        [self.view addSubview:_labelView];
    }
    return _labelView;
}

// 提示弹窗
- (void)showMessage:(NSString *)message {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UILabel *messageLabel = [[UILabel alloc] init];
    CGSize messageSize = CGSizeMake([message getSizeWithFont:[UIFont systemFontOfSize:12]].width + 30, 30);
    messageLabel.frame = CGRectMake((YLScreenWidth - messageSize.width) / 2, YLScreenHeight/2, messageSize.width, messageSize.height);
    messageLabel.text = message;
    messageLabel.font = [UIFont systemFontOfSize:12];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = YLColor(233.f, 233.f, 233.f);
    messageLabel.layer.cornerRadius = 5.0f;
    messageLabel.layer.masksToBounds = YES;
    [window addSubview:messageLabel];
    
    [UIView animateWithDuration:1 animations:^{
        messageLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [messageLabel removeFromSuperview];
    }];
}

@end
