//
//  YLSaleDetailController.m
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSaleDetailController.h"
#import "YLCommandView.h"
#import "YLCondition.h"
#import "YLChangePriceView.h"

@interface YLSaleDetailController ()

@property (nonatomic, strong) UIView *cover;
@property (nonatomic, strong) YLChangePriceView *changePriceView;

@end

@implementation YLSaleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    YLCommandView *command = [[YLCommandView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, 110)];
    [self.view addSubview:command];
    
    CGFloat width = (YLScreenWidth - 2 * YLLeftMargin - 5) / 2;
    YLCondition *changePirce = [YLCondition buttonWithType:UIButtonTypeCustom];
    changePirce.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(command.frame) + 5, width, 40);
    [changePirce setTitle:@"修改价格" forState:UIControlStateNormal];
    changePirce.type = YLConditionTypeWhite;
    [changePirce addTarget:self action:@selector(changePrice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePirce];
    
    YLCondition *soldOut = [YLCondition buttonWithType:UIButtonTypeCustom];
    soldOut.frame = CGRectMake(CGRectGetMaxX(changePirce.frame) + 5, CGRectGetMaxY(command.frame) + 5, width, 40);
    [soldOut setTitle:@"下架" forState:UIControlStateNormal];
    soldOut.type = YLConditionTypeWhite;
    [soldOut addTarget:self action:@selector(soldOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:soldOut];
    
    [self.view addSubview:self.cover];
    [self.cover addSubview:self.changePriceView];
}

- (void)changePrice {
    NSLog(@"修改价格");
    self.cover.hidden = NO;
}

- (void)soldOut {
    NSLog(@"下架");
}

- (UIView *)cover {
    if (!_cover) {
        _cover = [[UIView alloc] initWithFrame:CGRectMake(0, 64, YLScreenWidth, YLScreenHeight)];
        _cover.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5];
        _cover.hidden = YES;
    }
    return _cover;
}

- (YLChangePriceView *)changePriceView {
    if (!_changePriceView) {
        _changePriceView = [[YLChangePriceView alloc] initWithFrame:CGRectMake(0, YLScreenHeight - 214 - 64, YLScreenWidth, 214)];
        
        __weak typeof(self) weakSelf = self;
        _changePriceView.changePriceBlock = ^(NSString * _Nonnull price, NSString * _Nonnull floor, BOOL isAccept) {
            NSLog(@"价格：%@,底价:%@,是否接受议价：%d", price, floor, isAccept);
            weakSelf.cover.hidden = YES;
        };
    }
    return _changePriceView;
}

@end
