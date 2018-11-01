//
//  YLTableViewCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLTableViewCell.h"

//#define YLMargin 10


@interface YLTableViewCell ()

@property (nonatomic, strong) UIImageView *cellImage; // 图片
@property (nonatomic, strong) UILabel *nameL; // 名称
@property (nonatomic, strong) UILabel *subtitleL; // 子标题
@property (nonatomic, strong) UILabel *priceL; // 新车价格
@property (nonatomic, strong) UILabel *secondPriceL; // 二手价格
@property (nonatomic, strong) UIView *line;// 底线


@end

@implementation YLTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"cellID";
    YLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupOriginal];
    }
    return self;
}

// 初始化
- (void)setupOriginal {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.cellImage = imageView;
    
    UILabel *nameL = [[UILabel alloc] init];
    [self addSubview:nameL];
    self.nameL = nameL;
    
    UILabel *subtitleL = [[UILabel alloc] init];
    [self addSubview:subtitleL];
    self.subtitleL = subtitleL;
    
    UILabel *priceL = [[UILabel alloc] init];
    [self addSubview:priceL];
    self.priceL = priceL;
    
    UILabel *secondPriceL = [[UILabel alloc] init];
    secondPriceL.textColor = [UIColor redColor];
    secondPriceL.font = [UIFont systemFontOfSize:21];
    [self addSubview:secondPriceL];
    self.secondPriceL = secondPriceL;
    
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    self.line = line;
    
    self.cellImage.backgroundColor = [UIColor redColor];
//    self.nameL.backgroundColor = [UIColor redColor];
//    self.subtitleL.backgroundColor = [UIColor redColor];
//    self.priceL.backgroundColor = [UIColor redColor];
//    self.secondPriceL.backgroundColor = [UIColor redColor];
    self.line.backgroundColor = [UIColor redColor];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.cellImage.frame = CGRectMake(10, 10, 150, 120);
    
    float nameLx = CGRectGetMaxX(self.cellImage.frame) + YLMargin;
    self.nameL.frame = CGRectMake(nameLx, 10, 200, 60);
    self.nameL.numberOfLines = 0;
    self.nameL.lineBreakMode = NSLineBreakByWordWrapping;
    
    float subtitleLx = nameLx;
    float subtitleLy = CGRectGetMaxY(self.nameL.frame) + YLMargin;
    self.subtitleL.frame = CGRectMake(subtitleLx, subtitleLy, 100, 20);
    
    float secondPriceLx = subtitleLx;
    float secondPriceLy = CGRectGetMaxY(self.subtitleL.frame) + YLMargin;
    self.secondPriceL.frame = CGRectMake(secondPriceLx, secondPriceLy, 100, 20);
    
    float priceLx = CGRectGetMaxX(self.secondPriceL.frame) + YLMargin;
    float priceLy = secondPriceLy;
    self.priceL.frame = CGRectMake(priceLx, priceLy, 100, 20);
    
    float liney = CGRectGetMaxY(self.cellImage.frame) + YLMargin;
    float width = self.bounds.size.width;
    self.line.frame = CGRectMake(0, liney, width, 1);
}

- (void)setCellModel:(YLCellModel *)cellModel {
    
    _cellModel = cellModel;
//    self.imageView.image = [UIImage imageNamed:cellModel.image];
//    self.nameL.text = cellModel.name;
//    self.subtitleL.text = cellModel.subtitle;
//    self.secondPriceL.text = cellModel.secondPrice;
    self.priceL.text = [NSString stringWithFormat:@"新车价%@", cellModel.Price];
    
    self.nameL.text = @"别克 君威2013款 2.4L SIDI精英舒适型1a";
    self.subtitleL.text = @"年/3万公里";
    self.secondPriceL.text = @"13.0万";
    self.priceL.text = @"新车价0.0万";

}

@end
