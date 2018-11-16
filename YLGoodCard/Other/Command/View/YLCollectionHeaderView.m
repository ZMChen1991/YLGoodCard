//
//  YLCollectionHeaderView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/16.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCollectionHeaderView.h"

@implementation YLCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *lable = [[UILabel alloc] initWithFrame:self.frame];
    [self addSubview:lable];
    self.title = lable;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

@end
