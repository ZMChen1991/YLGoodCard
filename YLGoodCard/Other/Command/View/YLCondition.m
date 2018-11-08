//
//  YLCondition.m
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCondition.h"

@implementation YLCondition

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//        CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){0, 0, 0, 1});
//        [self.layer setBorderColor:borderColorRef];
//        [self.layer setBorderWidth:5.0];
    }
    return self;
}

- (void)setType:(YLConditionType)type {
    
    _type = type;
    switch (type) {
        case YLConditionTypeBlue:
            self.backgroundColor = YLColor(8.f, 169.f, 255.f);
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case YLConditionTypeWhite:
            self.backgroundColor = [UIColor whiteColor];
            [self setTitleColor:YLColor(8.f, 169.f, 255.f) forState:UIControlStateNormal];
            // 添加边框
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){0, 0, 0, 1});
            [self.layer setBorderColor:borderColorRef];
            [self.layer setBorderWidth:2.0];
            break;
        case YLConditionTypeGray:
            self.backgroundColor = YLColor(213.f, 213.f, 213.f);
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}
@end
