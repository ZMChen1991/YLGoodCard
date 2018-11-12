//
//  YLFunctionView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLFunctionView.h"

@interface YLFunctionView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *function1; // 存放即将看车、我的收藏、浏览记录、我的订阅
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array1;

@end

@implementation YLFunctionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    NSArray *array = @[@"即将看车", @"我的收藏", @"浏览记录", @"我的订阅", @"卖车订单", @"买车订单", @"砍价记录", @"降价提醒"];
    for (NSInteger i = 0; i < array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.function1 addObject:btn];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 176, self.frame.size.width, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
    
    self.array1 = @[@"电话客服", @"意见反馈"];
    [self addSubview:self.tableView];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 88 * 3 + 1, self.frame.size.width, 1)];
    line1.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line1];
}

- (void)btnClick:(UIButton *)sender {
    
    NSLog(@"YLFunctionView:%ld", (long)sender.tag);
    if (self.delegate && [self.delegate respondsToSelector:@selector(btnClickToController:)]) {
        [self.delegate btnClickToController:sender];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSInteger count = [self.function1 count];
    NSInteger width = self.frame.size.width / 4;
    NSInteger height = 88;
    for (NSInteger i = 0; i < count; i++) {
        NSInteger row = i / 4;
        NSInteger line = i % 4;
        UIButton *btn = self.function1[i];
        btn.frame = CGRectMake(line * width, row * height, width, height);
    }
    self.tableView.frame = CGRectMake(0, 177, self.frame.size.width, 89);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array1.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLFunctionView";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.array1[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    NSLog(@"%@",cell.textLabel.text);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"%@", self.array1[indexPath.row]);
    if (indexPath.row == 0) {
        NSLog(@"电话客服:%@",self.array1[indexPath.row]);
        
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(callTelephone)]) {
            [self.delegate callTelephone];
        }
    } else {
        NSLog(@"意见反馈:%@",self.array1[indexPath.row]);
        if (self.delegate && [self.delegate respondsToSelector:@selector(suggestions)]) {
            [self.delegate suggestions];
        }
    }
}


#pragma mark 懒加载
- (NSMutableArray *)function1 {
    
    if (!_function1) {
        _function1 = [NSMutableArray array];
    }
    return _function1;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
//        _tableView.separatorStyle = UITableViewStylePl ain;
        _tableView.backgroundColor = [UIColor redColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

@end
