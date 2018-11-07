//
//  YLTableHeaderView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLTableHeaderView.h"

@interface YLTableHeaderView ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;


@end

@implementation YLTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.icon];
        [self addSubview:self.title];
        [self addSubview:self.subTitle];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    float iconW = 30;
    
    switch (self.tableHeadertype) {
        case YLTableHeaderTypeNone:
            
            break;
        case YLTableHeaderTypeImage:
            
            self.icon.frame = CGRectMake(0, 0, iconW, height);
            self.title.frame = CGRectMake(iconW, 0, width - iconW, height);
            break;
        case YLTableHeaderTypeTitle:
            self.title.frame = self.frame;
            break;
        case YLTableHeaderTypeSubtitle:
            self.icon.frame = CGRectMake(0, 0, iconW, height);
            self.title.frame = CGRectMake(iconW, 0, width - iconW - width / 4, height);
            self.subTitle.frame = CGRectMake(CGRectGetMaxX(self.title.frame), 0, width - CGRectGetMaxX(self.title.frame), height);
            break;
    }
}

- (void)clichSubtitle:(YLButton *)sender {
    
    NSLog(@"YLTableHeaderView:%@", sender.titleLabel.text);
    if (sender.delegate && [sender.delegate respondsToSelector:@selector(checkMore)]) {
        [sender.delegate checkMore];
    }
}

#pragma mark 懒加载
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor redColor];
    }
    return _icon;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
//        _title.backgroundColor = [UIColor greenColor];
//        [_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        [_title setFont:[UIFont systemFontOfSize:16]];
    }
    return _title;
}
- (YLButton *)subTitle {
    
    if (!_subTitle) {
        _subTitle = [[YLButton alloc] init];
        [_subTitle addTarget:self action:@selector(clichSubtitle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subTitle;
}

- (void)setTableHeaderModel:(YLTableHeaderModel *)tableHeaderModel {
    _tableHeaderModel = tableHeaderModel;
    
    self.icon.image = [UIImage imageNamed:tableHeaderModel.icon];
    self.title.text = tableHeaderModel.title;
    [self.subTitle setTitle:tableHeaderModel.subtitle forState:UIControlStateNormal];
}

@end
