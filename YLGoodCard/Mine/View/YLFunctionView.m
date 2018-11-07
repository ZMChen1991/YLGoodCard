//
//  YLFunctionView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLFunctionView.h"

@interface YLFunctionView ()

@property (nonatomic, strong) UILabel *numberL;
@property (nonatomic, strong) UILabel *textL;

@end

@implementation YLFunctionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupOriginal];
    }
    return self;
}

- (void)setupOriginal {
    
    for (int i = 0; i < 4; i++) {
        
        self.numberL = [[UILabel alloc] init];
        [self addSubview:self.numberL];
        
        self.textL = [[UILabel alloc] init];
        [self addSubview:self.textL];
    }
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float numberLX = self.frame.size.width / 4;
    float numberLY = 0;
    float numberLW = numberLX;
    float numberLH = self.frame.size.height;
    self.numberL.frame = CGRectMake(numberLX, numberLY, numberLW, numberLH);
    
    float textLX = numberLX;
    float textLY = CGRectGetMaxY(self.numberL.frame);
    float textLW = self.frame.size.width;
    float textLH = self.frame.size.height;
    self.textL.frame = CGRectMake(textLX, textLY, textLW, textLH);
}

@end
