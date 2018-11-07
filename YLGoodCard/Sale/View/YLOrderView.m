//
//  YLOrderView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLOrderView.h"

@implementation YLOrderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupOriginal];
    }
    return self;
}

- (void)setupOriginal {
    
    self.saleBtn = [YLSaleButton buttonWithType:UIButtonTypeCustom];
    [self.saleBtn setTitle:@"预约卖车" forState:UIControlStateNormal];
    [self.saleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saleBtn addTarget:self action:@selector(sale) forControlEvents:UIControlEventTouchUpInside];
    [self.saleBtn setBackgroundColor:YLColor(44.f, 172.f, 63.f)];
    [self addSubview:self.saleBtn];
    
    self.consultBtn = [YLSaleButton buttonWithType:UIButtonTypeCustom];
    [self.consultBtn setTitle:@"免费咨询" forState:UIControlStateNormal];
    [self.consultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.consultBtn addTarget:self action:@selector(consult) forControlEvents:UIControlEventTouchUpInside];
    [self.consultBtn setBackgroundColor:YLColor(44.f, 172.f, 63.f)];
    [self addSubview:self.consultBtn];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float saleBtnX = YLMargin;
    float saleBtnY = YLMargin;
    float saleBtnW = self.frame.size.width - 2 * YLMargin;
    float saleBtnH = 50;
    self.saleBtn.frame = CGRectMake(saleBtnX, saleBtnY, saleBtnW, saleBtnH);
    
    float consultBtnX = YLMargin;
    float consultBtnY = CGRectGetMaxY(self.saleBtn.frame) + YLMargin;
    float consultBtnW = saleBtnW;
    float consultBtnH = saleBtnH;
    self.consultBtn.frame = CGRectMake(consultBtnX, consultBtnY, consultBtnW, consultBtnH);
}

- (void)sale {
    
    NSLog(@"预约卖车");
    if (self.saleBtn.delegate && [self.saleBtn.delegate respondsToSelector:@selector(pushController)]) {
        [self.saleBtn.delegate pushController];
    }
}

- (void)consult {
    
    NSLog(@"免费咨询");
}

@end
