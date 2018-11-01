//
//  YLTitleButton.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLTitleButton.h"

@implementation YLTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.layer.cornerRadius = 15.0;
        self.layer.masksToBounds = YES;
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    }
    return self;
}
@end
