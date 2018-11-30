//
//  YLMineController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//
/**
 1、登录
 2、即将看车
 3、我的收藏
 4、浏览记录
 5、买车订单
 6、卖车订单
 7、砍价记录
 */


#import "YLMineController.h"
#import "YLDetailController.h"
#import "YLSuggestionController.h"
#import "YLLoginController.h"
#import "YLSettingController.h"
#import "YLFunctionController.h"
#import "YLSubController.h"
#import "YLBrowseController.h"

#import "YLTableGroupHeader.h"
#import "YLFunctionView.h"
#import "YLTableViewCell.h"
#import "YLMineIcon.h"
#import "YLLoginHeader.h"


#import "YLAccount.h"
#import "YLAccountTool.h"
#import "YLMineTool.h"

// 浏览记录路径
#define YLBrowsingHistoryPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"browsingHistory.plist"]

@interface YLMineController () <YLFunctionViewDelegate, YLLoginHeaderDelegate, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YLLoginController *loginVc;
@property (nonatomic, strong) YLLoginHeader *loginHeader;
@property (nonatomic, strong) YLMineIcon *mineIcon;
@property (nonatomic, strong) YLFunctionView *functionView;

@property (nonatomic, strong) YLAccount *account;
@property (nonatomic, strong) NSMutableArray *browsingHistory;
@property (nonatomic, assign) NSInteger browsingHistoryCount;


@property (nonatomic, strong) NSArray *array;

@end

@implementation YLMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = @[@"电话客服", @"意见反馈"];
    
    [self setupNav];
    [self setupUI];
    
    self.account = [YLAccountTool account];
    if (self.account) {
        self.isLogin = YES;
        self.mineIcon.telephone = self.account.telephone;
        self.mineIcon.hidden = NO;
        self.loginHeader.hidden =YES;
        [self loadDate];
    } else {
        self.isLogin = NO;
        self.mineIcon.hidden = YES;
        self.loginHeader.hidden =NO;
    }
}

- (void)loadDate {
    
    // 获取即将看车的个数
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:self.account.telephone forKey:@"telephone"];
//    [param setValue:@"1" forKey:@"status"];
//    [YLMineTool lookforWithParam:param success:^(NSArray * _Nonnull result) {
//        NSLog(@"%@", result);
//    } failure:nil];
    
    // 获取本地浏览记录个数
    self.browsingHistoryCount = self.browsingHistory.count;
    NSLog(@"count:%ld", self.browsingHistoryCount);
    
    if (self.account) {
        // 获取我的收藏个数
        NSMutableDictionary *param1 = [NSMutableDictionary dictionary];
        [param1 setValue:self.account.telephone forKey:@"telephone"];
        [param1 setValue:[NSDate date] forKey:@"nowTime"];
        [param1 setValue:@"" forKey:@"lastTime"];
        [YLMineTool favoriteWithParam:param1 success:^(NSDictionary * _Nonnull result) {
            //        NSLog(@"%@", result);
            // 即将看车数：
            NSString *book = [result valueForKey:@"book"];
            // 收藏数：
            NSString *collect = [result valueForKey:@"collection"];
            // 降价提醒数：
            NSString *reduce = [result valueForKey:@"reduce"];
            NSLog(@"book:%@--collect:%@--reduce:%@", book, collect, reduce);
            NSMutableArray *mineArray = [NSMutableArray array];
            [mineArray addObject:book];
            [mineArray addObject:collect];
            [mineArray addObject:[NSString stringWithFormat:@"%ld", self.browsingHistoryCount]];
            [mineArray addObject:@"0"];
            self.functionView.numbers = mineArray;
        } failure:nil];
    } else {
        NSString *count = [NSString stringWithFormat:@"%ld", self.browsingHistoryCount];
        NSMutableArray *mineArray = [NSMutableArray arrayWithObjects:@"0", @"0", count, @"0", nil];
        self.functionView.numbers = mineArray;
    }
}

- (void)setupUI {
    
    self.mineIcon = [[YLMineIcon alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 96)];
    self.mineIcon.backgroundColor = YLColor(8.f, 169.f, 255.f);
    [self.view addSubview:self.mineIcon];
    
    self.loginHeader = [[YLLoginHeader alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 96)];
    self.loginHeader.backgroundColor = YLColor(8.f, 169.f, 255.f);
    self.loginHeader.delegate = self;
    [self.view addSubview:self.loginHeader];
    
    YLFunctionView *functionView = [[YLFunctionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.loginHeader.frame), YLScreenWidth, 176 + 1)];
    functionView.delegate = self;
    [self.view addSubview:functionView];
    self.functionView = functionView;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(functionView.frame), YLScreenWidth, YLScreenHeight - CGRectGetMaxY(functionView.frame))];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
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

//- (void)addchildViewControl {
//
//
//}


- (void)rightBarButtonItemClick {
    NSLog(@"点击了设置按钮");
    
    YLSettingController *setting = [[YLSettingController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLMineController";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.array[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self callTelephone];
    } else {
        [self suggestions];
    }
}

#pragma mark 代理
- (void)numberViewClickInIndex:(NSInteger)index {
    
    NSArray *array = @[@"即将看车",@"我的收藏", @"浏览记录", @"我的订阅"];
    NSLog(@"点击了%@跳转%@控制器", array[index], array[index]);
    
    if (index == 0) {
        NSArray *titles = @[@"在售", @"已下架"];
//        NSMutableDictionary *param = [NSMutableDictionary dictionary];
//        [param setValue:self.account.telephone forKey:@"telephone"];
//        [param setValue:@"1" forKey:@"status"]; // 1：待约定 2：合同签署 3：复检过户 4：交易完成
        NSArray *params = @[@"1", @"4"];
        YLFunctionController *fun = [[YLFunctionController alloc] init];
        fun.title = array[index];
        fun.titles = titles;
        fun.params = params;
        [self.navigationController pushViewController:fun animated:YES];
        return;
    }
    if (index == 1) {
        NSArray *titles = @[@"在售", @"已下架"];
        NSArray *params = @[@"3", @"0"];
        YLFunctionController *fun = [[YLFunctionController alloc] init];
        fun.title = array[index];
        fun.titles = titles;
        fun.params = params;
        [self.navigationController pushViewController:fun animated:YES];
        return;
    }
    if (index == 2) {
        YLBrowseController *browse = [[YLBrowseController alloc] init];
        browse.title = array[index];
        [self.navigationController pushViewController:browse animated:YES];
    }
    if (index == 3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"此功能以后开放" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
//    NSArray *titles = @[@"在售", @"已下架"];
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//
//    YLFunctionController *fun = [[YLFunctionController alloc] init];
//    fun.title = array[index];
//    fun.titles = titles;
//    [self.navigationController pushViewController:fun animated:YES];
}

- (void)skipToLogin {
    
    NSLog(@"点击了登录按钮");
    [self.navigationController pushViewController:self.loginVc animated:YES];
    __weak typeof(self) weakSelf = self;
    self.loginVc.loginBlock = ^(NSString *string) {
        NSLog(@"mineVC:%@", string);
        weakSelf.isLogin = YES;
    };
}

- (void)btnClickToController:(UIButton *)sender {
    
    // 这里判断用户是否登录，如果没有则跳转登录界面
    if(self.account) {
        NSLog(@"已登录");
        NSLog(@"%@",sender.titleLabel.text);
        NSString *title = sender.titleLabel.text;
        if (sender.tag == 100) {
            NSLog(@"%@----卖车订单", title);
        }
        if (sender.tag == 101) {
            NSLog(@"%@=----买车订单", title);
        }
        if (sender.tag == 102) {
            NSLog(@"%@=--=-砍价记录", title);
            YLFunctionController *lookCar = [[YLFunctionController alloc] init];
            lookCar.navigationItem.title = title;
            [self.navigationController pushViewController:lookCar animated:YES];
        }
        if (sender.tag == 103) {
            NSLog(@"降价提醒");
        }
    } else {
        NSLog(@"没有登录");
        [self.navigationController pushViewController:self.loginVc animated:YES];
    }
}

- (void)callTelephone {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"13800138000" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    alert.delegate = self;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex:%ld", buttonIndex);
    if (buttonIndex == 1) {
        [self test];
        NSLog(@"拨打电话");
    }
}

- (void)test {
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", @"10086"];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

- (void)suggestions {
    
    NSLog(@"弹出意见反馈页面");
    YLSuggestionController *suggestionVc = [[YLSuggestionController alloc] init];
    [self.navigationController pushViewController:suggestionVc animated:YES];
}


#pragma mark 懒加载
- (YLLoginController *)loginVc {
    if (!_loginVc) {
        _loginVc = [[YLLoginController alloc] init];
    }
    return _loginVc;
}

- (NSMutableArray *)browsingHistory {
    
    if (!_browsingHistory) {
        _browsingHistory = [NSKeyedUnarchiver unarchiveObjectWithFile:YLBrowsingHistoryPath];
        if (!_browsingHistory) {
            _browsingHistory = [NSMutableArray array];
        }
    }
    return _browsingHistory;
}

- (NSInteger)browsingHistoryCount {
    if (!_browsingHistoryCount) {
        _browsingHistoryCount = self.browsingHistory.count;
    }
    return _browsingHistoryCount;
}

- (void)setIsLogin:(BOOL)isLogin {
    _isLogin = isLogin;
    if (isLogin) {
        self.mineIcon.telephone = self.account.telephone;
        self.mineIcon.hidden = NO;
        self.loginHeader.hidden = YES;
        [self loadDate];
    } else {
        self.mineIcon.hidden = YES;
        self.loginHeader.hidden = NO;
        NSString *count = [NSString stringWithFormat:@"%ld", self.browsingHistoryCount];
        NSMutableArray *mineArray = [NSMutableArray arrayWithObjects:@"0", @"0", count, @"0", nil];
        self.functionView.numbers = mineArray;
    }
}

@end
