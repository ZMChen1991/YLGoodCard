//
//  YLMineHeader.m
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLMineHeader.h"

@implementation YLMineHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.header = [[YLLoginHeader alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 96)];
    self.header.status = YLLoginStatusDown;
    self.header.backgroundColor = [UIColor greenColor];
    [self addSubview:self.header];
    
    self.fun = [[YLFunctionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.header.frame), YLScreenWidth, 176 + 88)];
    //    fun.backgroundColor = [UIColor redColor];
    [self addSubview:self.fun];
}


@end
