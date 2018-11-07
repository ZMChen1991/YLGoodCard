//
//  YLTitleBar.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLTitleBar.h"

@implementation YLTitleBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:YLColor(193.f, 198.f, 205.f) forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.layer.cornerRadius = 15.0;
        self.layer.masksToBounds = YES;
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    }
    return self;
}
@end
