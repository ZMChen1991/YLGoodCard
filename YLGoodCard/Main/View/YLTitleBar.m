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
        [self setTitleColor:YLColor(155.f, 155.f, 155.f	) forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        self.alpha = 0.5;
        self.backgroundColor = YLColor(255.f, 255.f, 255.f);
    }
    return self;
}
@end
