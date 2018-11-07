//
//  YLDetailHeaderCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailHeaderCell.h"

@interface YLDetailHeaderCell ()

@property (nonatomic, strong) UIImageView *headerView;// 图片
@property (nonatomic, strong) UILabel *numberL;// 图片数量
@property (nonatomic, strong) UILabel *titleL;// 标题
@property (nonatomic, strong) UIButton *labelBtn;// 标签
@property (nonatomic, strong) UILabel *label1;// 车主报价
@property (nonatomic, strong) UILabel *label2;// 新车含税价
@property (nonatomic, strong) UIButton *bargainBtn;// 砍价
@property (nonatomic, strong) UILabel *priceL;// 价格

@end


@implementation YLDetailHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
