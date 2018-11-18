//
//  YLDetailFooterView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailFooterView.h"


@interface YLDetailFooterView ()

@property (nonatomic, strong) UIButton *favorite;
@property (nonatomic, strong) UIButton *customer;


@end

@implementation YLDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.favorite = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.favorite.backgroundColor = [UIColor redColor];
//    [self.favorite setTitle:@"收藏" forState:UIControlStateNormal];
//    self.favorite.titleLabel.font = [UIFont systemFontOfSize:11];
//    self.favorite.imageView.backgroundColor = [UIColor redColor];
    [self.favorite setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    self.favorite.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.favorite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.favorite.frame = CGRectMake(YLLeftMargin, YLTopMargin, 27, self.frame.size.height - 2 * YLTopMargin);
    [self.favorite addTarget:self action:@selector(clickFavorite) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.customer = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.customer.backgroundColor = [UIColor greenColor];
//    [self.customer setTitle:@"客服" forState:UIControlStateNormal];
//    self.customer.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.customer setImage:[UIImage imageNamed:@"客服"] forState:UIControlStateNormal];
    [self.customer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.customer.frame = CGRectMake(CGRectGetMaxX(self.favorite.frame) + 5, YLTopMargin, 27, self.frame.size.height - 2 * YLTopMargin);
    [self.customer addTarget:self action:@selector(clickCustomer) forControlEvents:UIControlEventTouchUpInside];
    
    self.bargain = [YLCondition buttonWithType:UIButtonTypeCustom];
    [self.bargain setTitle:@"砍价" forState:UIControlStateNormal];
    self.bargain.type = YLConditionTypeWhite;
    self.bargain.frame = CGRectMake(CGRectGetMaxX(self.customer.frame) + YLTopMargin, YLTopMargin, 125, self.frame.size.height - 2 * YLTopMargin);
//    [self.bargain addTarget:self action:@selector(clickBargain) forControlEvents:UIControlEventTouchUpInside];
    
    self.order = [YLCondition buttonWithType:UIButtonTypeCustom];
    [self.order setTitle:@"预约看车" forState:UIControlStateNormal];
    self.order.type = YLConditionTypeBlue;
    self.order.frame = CGRectMake(CGRectGetMaxX(self.bargain.frame) + YLTopMargin, YLTopMargin, 125, self.frame.size.height - 2 * YLTopMargin);
//    [self.order addTarget:self action:@selector(clickOrder) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.favorite];
    [self addSubview:self.customer];
    [self addSubview:self.bargain];
    [self addSubview:self.order];
}

- (void)clickFavorite {
    NSLog(@"favorite");
}

- (void)clickCustomer {
    NSLog(@"customer");
}

- (void)clickBargain {
    NSLog(@"bargain");
}

- (void)clickOrder {
    NSLog(@"order");
}

@end
