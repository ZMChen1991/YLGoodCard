//
//  YLNoneView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLNoneView.h"
#import "YLCondition.h"

@implementation YLNoneView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.frame = CGRectMake(YLScreenWidth / 2 - 61, 60, 122, 122);
    icon.image = [UIImage imageNamed:@"暂无收藏"];
    [self addSubview:icon];
    
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(0, CGRectGetMaxY(icon.frame), YLScreenWidth, 22);
    title.text  = @"暂无收藏记录";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16];
    [self addSubview:title];
    
    YLCondition *go = [YLCondition buttonWithType:UIButtonTypeCustom];
    go.frame = CGRectMake(YLScreenWidth / 2 - 70, CGRectGetMaxY(title.frame) + 20, 141, 44);
    go.type = YLConditionTypeBlue;
    [go setTitle:@"现在去逛逛" forState:UIControlStateNormal];
    [go addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:go];
    
}

- (void)go {
    
    NSLog(@"现在去逛逛");
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

@end
