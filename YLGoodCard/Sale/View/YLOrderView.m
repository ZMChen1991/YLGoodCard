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
<<<<<<< HEAD
    self.saleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.saleBtn.type = YLConditionTypeBlue;
=======
    [self.saleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
>>>>>>> parent of 1116516... a
    [self.saleBtn addTarget:self action:@selector(sale:) forControlEvents:UIControlEventTouchUpInside];
    [self.saleBtn setBackgroundColor:YLColor(44.f, 172.f, 63.f)];
    [self addSubview:self.saleBtn];
    
    self.consultBtn = [YLSaleButton buttonWithType:UIButtonTypeCustom];
    [self.consultBtn setTitle:@"免费咨询" forState:UIControlStateNormal];
<<<<<<< HEAD
    self.consultBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.consultBtn.type = YLConditionTypeWhite;
=======
    [self.consultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
>>>>>>> parent of 1116516... a
    [self.consultBtn addTarget:self action:@selector(consult:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)sale:(YLSaleButton *)sender {
    
    NSLog(@"预约卖车:%@", sender.titleLabel.text);
    if (self.saleBtn.delegate && [self.saleBtn.delegate respondsToSelector:@selector(pushController:)]) {
        [self.saleBtn.delegate pushController:sender];
    }
    
}

- (void)consult:(YLSaleButton *)sender {
    
    NSLog(@"免费咨询:%@", sender.titleLabel.text);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"联系电话" message:@"0662-12345678" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}

@end
