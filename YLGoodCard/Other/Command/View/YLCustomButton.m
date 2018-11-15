//
//  YLCustomButton.m
//  YLGoodCard
//
//  Created by lm on 2018/11/16.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCustomButton.h"

@implementation YLCustomButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:YLColor(155.f, 155.f, 155.f) forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height * 0.7;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat imgX = contentRect.size.width/4;
    CGFloat imgY = 15;
    CGFloat imgW = contentRect.size.width/2;
    CGFloat imgH = contentRect.size.height * 0.5;
    return CGRectMake(imgX, imgY, imgW, imgH);
}

@end
