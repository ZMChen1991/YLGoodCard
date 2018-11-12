//
//  YLLinkageView.m
//  仿美团菜单栏
//
//  Created by lm on 2017/5/26.
//  Copyright © 2017年 CocaCola. All rights reserved.
//

#import "YLLinkageView.h"
#import "YLCustomPrice.h"
#import "YLSelectView.h"

#define SCREENWIDTH self.frame.size.width
#define LEFTWIDTH   (SCREENWIDTH / 3)
#define RIGHTWIDTH  (SCREENWIDTH - LEFTWIDTH)
#define HEIGHT       self.frame.size.height
#define btnH 35



@interface YLLinkageView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;// 数据
@property (nonatomic, assign) BOOL selectState;// 默认不选中
@property (nonatomic, strong) UIView *background;// 蒙版
@property (nonatomic, strong) YLCustomPrice *customPrice;// 价格页面
@property (nonatomic, strong) UITableView *leftTableView;// 排序列表
@property (nonatomic, strong) YLSelectView *selectView;// 筛选页面

@end

static NSString * const leftIdentifier = @"LeftCellIdentifier";

@implementation YLLinkageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = @[@"最新上架", @"价格最低", @"价格最高", @"车龄最短", @"里程最少"];
        [self setUI];
    }
    return self;
}

- (void)setUI {

    NSArray *btns = @[@"排序", @"品牌", @"价格", @"筛选"];
    float btnW = YLScreenWidth / btns.count; // 屏幕宽/按钮数
    for (int i = 0; i < btns.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnW * i, 0, btnW, btnH);
        btn.tag = 100 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@", btns[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        if (i > 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(btnW * i, 0, 1, btnH)]; // 按钮宽、按钮高
            line.backgroundColor = YLColor(237.f, 237.f, 237.f);
            [self addSubview:line];
        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, btnH, YLScreenWidth, 1)]; // 屏幕宽、按钮高
        line.backgroundColor = YLColor(237.0, 237.0, 237.0);
        [self addSubview:line];
    }
//    [self.background addSubview:self.leftTableView];
//    [self.background addSubview:self.customPrice];
//    [self.background addSubview:self.selectView];
//    [self addSubview:self.background];
//    
//    self.background.hidden = YES;
//    self.leftTableView.hidden = YES;
//    self.customPrice.hidden = YES;
//    self.selectView.hidden = YES;
//    self.selectState = NO;
}

// 选中状态时，如果点击的是排序按钮，则显示列表，否则隐藏
- (void)selectBtn:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushCoverView:)]) {
        [self.delegate pushCoverView:sender];
    }

//    self.selectState = !self.selectState;
//    if (self.selectState) {
//        switch (sender.tag) {
//            case 100:
//                NSLog(@"排序");
//                self.background.hidden = NO;
//                self.leftTableView.hidden = NO;
//                self.customPrice.hidden = YES;
//                self.selectView.hidden = YES;
//                break;
//            case 101:
//                NSLog(@"品牌");
//                self.background.hidden = YES;
//                self.leftTableView.hidden = YES;
//                self.customPrice.hidden = YES;
//                self.selectView.hidden = YES;
//                self.selectState = NO;
//                break;
//            case 102:
//                NSLog(@"价格");
//                self.background.hidden = NO;
//                self.leftTableView.hidden = YES;
//                self.customPrice.hidden = NO;
//                self.selectView.hidden = YES;
//                break;
//            case 103:
//                NSLog(@"筛选");
//                self.background.hidden = NO;
//                self.leftTableView.hidden = YES;
//                self.customPrice.hidden = YES;
//                self.selectView.hidden = NO;
//                break;
//            default:
//                break;
//        }
//    } else {
//        self.background.hidden = YES;
//        self.leftTableView.hidden = YES;
//        self.customPrice.hidden = YES;
//        self.selectView.hidden = YES;
//    }
    NSLog(@"%@--%d", sender.titleLabel.text, self.selectState);
}

//#pragma mark UItableViewDelegate/UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//        return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return self.dataArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftTableViewCellID"];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataArray[indexPath.row]];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    // 具体逻辑还需依照数据来修改
//    self.background.hidden = YES; //点击cell之后去获取筛选后的数据，刷新控制器里面的数据
//    self.selectState = NO;
//    NSLog(@"%@", self.dataArray[indexPath.row]);
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//        return 35;
//}

- (UITableView *)leftTableView {

    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, YLScreenHeight) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leftTableViewCellID"];
        _leftTableView.tableFooterView = [[UIView alloc] init];
        _leftTableView.backgroundColor =[UIColor clearColor];
        _leftTableView.backgroundView = [[UIView alloc] init];
        _leftTableView.bounces = NO;// 禁止弹跳
    }
    return _leftTableView;
}
//
//- (UIView *)background {
//    if (!_background) {
//        _background = [[UIView alloc] initWithFrame:CGRectMake(0, btnH+1, YLScreenWidth, YLScreenHeight)];
//        _background.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
////        _background.backgroundColor = [UIColor redColor];
////        [_background addSubview:self.leftTableView];
//        [self addSubview:_background];
//    }
//    return _background;
//}
//
//- (YLCustomPrice *)customPrice {
//    if (!_customPrice) {
//        _customPrice = [[YLCustomPrice alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 226)];
//        _customPrice.backgroundColor = [UIColor whiteColor];
////        [self.background addSubview:_customPrice];
//    }
//    return _customPrice;
//}
//
//- (YLSelectView *)selectView {
//    if (!_selectView) {
//        _selectView = [[YLSelectView alloc] initWithFrame:CGRectMake(self.background.frame.size.width - 328, 0, 328, self.background.frame.size.height)];
//        _selectView.backgroundColor = [UIColor redColor];
//    }
//    return _selectView;
//}

@end
