//
//  YLTableGroupHeader.m
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLTableGroupHeader.h"

@interface YLTableGroupHeader ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailTitleLabel;
@property (nonatomic, strong) UIImageView *arrowIcon;
@property (nonatomic, strong) UIView *line;

@end

@implementation YLTableGroupHeader

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title detailTitle:(NSString *)detailTitle arrowImage:(NSString *)arrowImage {
    
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:image];
        [self addSubview:icon];
        self.icon = icon;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *detailTitleLabel = [[UILabel alloc] init];
        detailTitleLabel.text = detailTitle;
        detailTitleLabel.textAlignment = NSTextAlignmentRight;
        detailTitleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:detailTitleLabel];
        self.detailTitleLabel = detailTitleLabel;
        
        UIImageView *arrowIcon = [[UIImageView alloc] init];
        arrowIcon.image = [UIImage imageNamed:arrowImage];
        [self addSubview:arrowIcon];
        self.arrowIcon = arrowIcon;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = YLColor(233.f, 233.f, 233.f);
        [self addSubview:line];
        self.line = line;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    float iconH = height - 2 * YLTopMargin;
    float titleW = width / 3;
    self.icon.frame = CGRectMake(YLLeftMargin, YLTopMargin, 20, iconH);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.icon.frame) + 5, YLTopMargin, titleW, iconH);
    self.arrowIcon.frame = CGRectMake(width - YLTopMargin - 8, YLTopMargin  + 4, 8, iconH / 2);
    self.detailTitleLabel.frame = CGRectMake(CGRectGetMidX(self.arrowIcon.frame) - titleW - 5, YLTopMargin, titleW, iconH);
    self.line.frame = CGRectMake(0, CGRectGetMaxY(self.icon.frame) + YLTopMargin, width, 1);
}

@end
