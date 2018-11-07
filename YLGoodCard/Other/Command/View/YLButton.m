//
//  YLButton.m
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLButton.h"

#define YLButtonBili 0.9
#define YLButtonImageWidth 15

@implementation YLButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // 设置按钮文字颜色
        [self setTitleColor:YLColor(182.f, 182.f, 182.f) forState:UIControlStateNormal];
        // 设置按钮文字居中
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        // 让图片按照原来的宽高比显示出来
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        // 设置按钮文字的字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        // 设置按钮里面的内容（UILabel、UIImageView）居中
         self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return self;
}

#pragma mark - 重写了UIButton的方法
#pragma mark 控制UILabel的位置和尺寸
// contentRect其实就是按钮的位置和尺寸
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleWidth = contentRect.size.width - YLButtonImageWidth;
    CGFloat titleHeight = contentRect.size.height;
    
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

#pragma mark 控制UIImageView的位置和尺寸
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = contentRect.size.width - YLButtonImageWidth;
    CGFloat imageY = 0;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height;
    
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}



@end
