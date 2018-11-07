//
//  YLBuyController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBuyController.h"
#import "YLTitleBar.h"
#import "YLTableViewCell.h"
#import "YLSearchController.h"
#import "YLLinkageView.h"


#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height
#define btnH 35

@interface YLBuyController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YLLinkageView *linkageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *leftTableView;// 一级
@property (nonatomic, strong) NSArray *dataArray;// 数据
@property (nonatomic, assign) BOOL selectState;// 默认不选中

@end

@implementation YLBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self setUI];
    self.dataArray = @[@"最新上架", @"价格最低", @"价格最高", @"车龄最短", @"里程最少"];
}

#pragma mark 私有方法
- (void)setNav {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"阳江" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    YLTitleBar *titleBtn = [[YLTitleBar alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [titleBtn setTitle:@"    搜索您想要的车   " forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.backgroundColor = YLColor(239.f, 242.f, 247.f);
    self.navigationItem.titleView = titleBtn;
}

- (void)setUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, screenW, screenH)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//
    NSArray *btns = @[@"排序", @"品牌", @"价格", @"筛选"];
    
    float btnW = YLScreenWidth / btns.count;
    for (int i = 0; i < btns.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnW * i, 64, btnW, btnH);
        btn.tag = 100 + i;
//        btn.backgroundColor = [UIColor redColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@", btns[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        if (i > 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(btnW * i, 64, 1, btnH)];
            line.backgroundColor = YLColor(237.f, 237.f, 237.f);
            [self.view addSubview:line];
        }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, btnH+64, YLScreenWidth, 5)];
    line.backgroundColor = YLColor(237.0, 237.0, 237.0);
    [self.view addSubview:line];
    }
    
    [self.view addSubview:self.leftTableView];
    self.leftTableView.hidden = YES;
    self.selectState = NO;
}

// 选中状态时，如果点击的是排序按钮，则显示列表，否则隐藏
- (void)selectBtn:(UIButton *)sender {
    
    self.selectState = !self.selectState;
    NSString *btnStr = sender.titleLabel.text;
    if (self.selectState) {
        if ([btnStr isEqualToString:@"排序"]) {
            self.leftTableView.hidden = NO;
            NSLog(@"%@", sender.titleLabel.text);
        }
    } else {
        self.leftTableView.hidden = YES;
    }
    if ([btnStr isEqualToString:@"品牌"]) {
        NSLog(@"%@", sender.titleLabel.text);
        self.selectState = NO;
    }
    if ([btnStr isEqualToString:@"价格"]) {
        NSLog(@"%@", sender.titleLabel.text);
    }
    if ([btnStr isEqualToString:@"筛选"]) {
        NSLog(@"%@", sender.titleLabel.text);
        self.selectState = NO;
    }
}

- (void)titleClick {
    
    NSLog(@"title被点击了！");
    YLSearchController *searchVc = [[YLSearchController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}

- (void)leftBarButtonItemClick {
    
    NSLog(@"leftBarButtonItem被点击了！");
}

- (void)rightBarButtonItemClick {
    
    NSLog(@"rightBarButtonItem被点击了！");
}

#pragma mark UItableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 判断表
    if (tableView == self.tableView) {
        return 1;
    } else {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.tableView) {
        return 10;
    } else {
        return self.dataArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView) {
        YLTableViewCell *cell = [YLTableViewCell cellWithTableView:tableView];
        cell.cellModel = nil;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftTableViewCellID"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataArray[indexPath.row]];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.leftTableView) {
        // 具体逻辑还需依照数据来修改
        self.leftTableView.hidden = YES; //点击cell之后去获取筛选后的数据，刷新控制器里面的数据
        self.selectState = NO;
        NSLog(@"%@", self.dataArray[indexPath.row]);
    }
    NSLog(@"点击了%ldcell", indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView) {
        return 140;
    } else {
        return 35;
    }
}


#pragma mark -- 懒加载
- (YLLinkageView *)linkageView {
    if (!_linkageView) {
        _linkageView = [[YLLinkageView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, YLScreenHeight)];
        [self.view addSubview:_linkageView];
//        self.linkageView.delegate = self;
    }
    return _linkageView;
}

- (UITableView *)leftTableView {
    
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, btnH + 64, YLScreenWidth, YLScreenHeight) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leftTableViewCellID"];
        _leftTableView.tableFooterView = [[UIView alloc] init];
    }
    return _leftTableView;
}

@end
