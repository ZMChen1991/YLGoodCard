//
//  YLLinkageView.m
//  仿美团菜单栏
//
//  Created by lm on 2017/5/26.
//  Copyright © 2017年 CocaCola. All rights reserved.
//

#import "YLLinkageView.h"

#define SCREENWIDTH self.frame.size.width
#define LEFTWIDTH   (SCREENWIDTH / 3)
#define RIGHTWIDTH  (SCREENWIDTH - LEFTWIDTH)
#define HEIGHT       self.frame.size.height
#define btnH 30



@interface YLLinkageView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *leftTableView;// 一级
@property (nonatomic, strong) NSArray *dataArray;// 数据
@property (nonatomic, assign) BOOL selectState;// 默认不选中

@end

static NSString * const leftIdentifier = @"LeftCellIdentifier";

@implementation YLLinkageView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        self.dataArray = @[@"最新上架", @"价格最低", @"价格最高", @"车龄最短", @"里程最少"];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, btnH)];
    
    NSArray *btns = @[@"排序", @"品牌", @"价格", @"筛选"];
    
    CGFloat btnW = SCREENWIDTH / btns.count;
    for (int i = 0; i < btns.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnW * i, 0, btnW, btnH);
        btn.tag = 100 + i;
//        btn.backgroundColor = [UIColor redColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@", btns[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        if (i > 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(btnW * i, 0, 1, btnH)];
            line.backgroundColor = YLColor(237.f, 237.f, 237.f);
            [view addSubview:line];
        }
    }
    
    [self addSubview:view];
    [self addSubview:self.leftTableView];
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
    }
    if ([btnStr isEqualToString:@"价格"]) {
        NSLog(@"%@", sender.titleLabel.text);
    }
    if ([btnStr isEqualToString:@"筛选"]) {
        NSLog(@"%@", sender.titleLabel.text);
    }
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftIdentifier];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // 具体逻辑还需依照数据来修改
    self.leftTableView.hidden = YES; //点击cell之后去获取筛选后的数据，刷新控制器里面的数据
    self.selectState = NO;
    NSLog(@"%@", self.dataArray[indexPath.row]);
}

#pragma mark - getter 、Setter
- (UITableView *)leftTableView {

    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, btnH, SCREENWIDTH, HEIGHT) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:leftIdentifier];
        _leftTableView.tableFooterView = [[UIView alloc] init];
    }
    return _leftTableView;
}


@end
