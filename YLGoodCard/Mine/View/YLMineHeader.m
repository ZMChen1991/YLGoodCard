//
//  YLMineHeader.m
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLMineHeader.h"
#import "YLAccount.h"
#import "YLAccountTool.h"

@implementation YLMineHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.mineIcon = [[YLMineIcon alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 96)];
    self.mineIcon.backgroundColor = YLColor(8.f, 169.f, 255.f);
    [self addSubview:self.mineIcon];
    self.loginHeader = [[YLLoginHeader alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 96)];
    self.loginHeader.backgroundColor = YLColor(8.f, 169.f, 255.f);
    [self addSubview:self.loginHeader];
    
    
    self.fun = [[YLFunctionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.loginHeader.frame), YLScreenWidth, 176 + 88)];
    //    fun.backgroundColor = [UIColor redColor];
    [self addSubview:self.fun];
}

- (void)setStatus:(YLLoginStatus)status {
    
    _status = status;
    if (status == YLLoginStatusUp) {
        YLAccount *account = [YLAccountTool account];
        self.mineIcon.hidden = NO;
        self.mineIcon.telephone = account.telephone;
        self.loginHeader.hidden = YES;
    } else {
        self.mineIcon.hidden = YES;
        self.loginHeader.hidden = NO;
    }
    
}

@end
