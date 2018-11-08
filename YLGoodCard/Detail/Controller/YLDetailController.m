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

@interface YLDetailController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *bg;
@property (nonatomic, strong) UIView *labelView;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation YLDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    
//    YLDetailHeaderView *header = [[YLDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 360)];
//    header.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:header];
//
//    YLDetailFooterView *footer = [[YLDetailFooterView alloc] initWithFrame:CGRectMake(0, 500, YLScreenWidth, 60)];
//    [self.view addSubview:footer];
    
//    [self setupUI];
    
//    [self setupUI1];
    [self addTableView];
}

- (void)addTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.bounces = NO; // 禁止弹跳
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    YLDetailHeaderView *header = [[YLDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 360)];
    self.tableView.tableHeaderView = header;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        YLSafeguardCell *cell = [YLSafeguardCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        YLInformationCell *cell = [YLInformationCell cellWithTable:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        return 160;
    } else {
        
        return 180;
    }
}

- (void)setupUI1 {
    
    NSArray *array = @[@"表显里程", @"上牌时间", @"车牌所在地", @"看车地点", @"排放量", @"迁入地为准", @"变速箱", @"登记证为准", @"年检到期", @"商业险到期", @"交强险到期"];
    NSArray *array1 = @[@"12.8公里", @"2015-10-10", @"阳江", @"阳东", @"1.8", @"国五", @"自动", @"0次过户", @"2019.08", @"2019.08", @"2019.08"];
    
    NSUInteger count = array.count;
    for (int i = 0 ; i < count; i++) {
        int row = i / 2;
        int line = i % 2;
        float width = (YLScreenWidth - 2 * YLLeftMargin) / 2;
        float height = 30;
        CGRect frame = CGRectMake(line * width, row * height, width, height);
        UIView *view = [self setupTitle:array[i] subtitle:array1[i] frame:frame];
        [self.labelView addSubview:view];
    }
}

- (UIView *)labelView {
    if (!_labelView) {
        CGRect frame = CGRectMake(YLLeftMargin, 64 + YLTopMargin, YLScreenWidth - 2 * YLLeftMargin, 180);
        _labelView = [[UIView alloc] initWithFrame:frame];
        [self.view addSubview:_labelView];
    }
    return _labelView;
}


- (UIView *)setupTitle:(NSString *)title subtitle:(NSString *)subtitle frame:(CGRect)frame {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 65, view.frame.size.height)];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = YLColor(155.f, 155.f, 155.f);
    label1.text = title;
    label1.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, view.frame.size.width - 65 - 10, view.frame.size.height)];
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = YLColor(51.f, 51.f, 51.f);
    label2.text = subtitle;
    label2.textAlignment = NSTextAlignmentRight;
    [view addSubview:label2];
    return view;
}


- (void)setupUI {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, YLScreenWidth, YLScreenHeight)];
    
    NSArray *array = @[@"售后保障", @"30天可退", @"调表车赔付", @"禁售抢盗车"];
    float width = (YLScreenWidth - 2 * YLLeftMargin) / array.count;
    float height = 80;
    for (int i = 0; i < array.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * width + YLLeftMargin, YLLeftMargin, width, height)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:YLRandomColor];
        [view addSubview:btn];
    }
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(YLLeftMargin, height, YLScreenWidth - 2 * YLLeftMargin, height)];
    image.backgroundColor = [UIColor redColor];
    [view addSubview:image];
    self.bg = image;
    
    [self.view addSubview:view];
}
- (void)click {
    
    NSLog(@"click");
    self.bg.backgroundColor = YLRandomColor;
}

- (void)setupNav {
    
    self.navigationItem.title = @"详情";
    UIBarButtonItem *down = [[UIBarButtonItem alloc] initWithTitle:@"降价通知" style:UIBarButtonItemStylePlain target:self action:@selector(down)];
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItems = @[share, down];
}

- (void)down {
    NSLog(@"降价通知");
}

- (void)share {
    NSLog(@"分享");
}

@end
