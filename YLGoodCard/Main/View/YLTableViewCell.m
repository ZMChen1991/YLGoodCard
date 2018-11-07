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
//        self.backgroundColor = [UIColor redColor];
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
    nameL.textColor = YLColor(116.f, 116.f, 116.f);
    nameL.font = [UIFont systemFontOfSize:14];
    [self addSubview:nameL];
    self.nameL = nameL;
    
    UILabel *subtitleL = [[UILabel alloc] init];
    subtitleL.textColor = YLColor(116.f, 116.f, 116.f);
    subtitleL.font = [UIFont systemFontOfSize:14];
    [self addSubview:subtitleL];
    self.subtitleL = subtitleL;
    
    UILabel *priceL = [[UILabel alloc] init];
    priceL.textColor = YLColor(116.f, 116.f, 116.f);
    priceL.font = [UIFont systemFontOfSize:14];
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
    self.line.backgroundColor = YLColor(233.f, 233.f, 233.f);
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.cellImage.frame = CGRectMake(10, 10, 150, 120);
//    [self.cellImage makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(YLTopMargin);
//        make.left.equalTo(YLLeftMargin);
//        make.width.equalTo(120);
//        make.height.equalTo(60);
//    }];
//
//    [self.nameL makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(YLTopMargin);
//        make.right.equalTo(-YLLeftMargin);
//        make.left.equalTo(self.cellImage.right).equalTo(YLLeftMargin);
//        make.height.equalTo(34);
//    }];
//
//    [self.subtitleL makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.nameL.bottom).equalTo(textMargin);
//        make.left.right.equalTo(self.nameL);
//        make.height.equalTo(17);
//    }];
//
//    [self.secondPriceL makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.nameL);
//        make.top.equalTo(self.subtitleL.bottom).equalTo(textMargin);
//        make.bottom.equalTo(YLBottomMargin);
//        make.width.equalTo(64);
//    }];
//
//    [self.priceL makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.secondPriceL).equalTo(textMargin);
//        make.left.equalTo(self.secondPriceL.right).equalTo(textMargin);
//        make.right.equalTo(YLTopMargin);
//        make.bottom.equalTo(YLBottomMargin);
//    }];
//
//    [self.line makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.cellImage.bottom).equalTo(YLTopMargin);
//        make.height.equalTo(1);
//        make.left.right.equalTo(0);
//    }];
    
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
    // 添加中划线
    NSString *str = @"新车价0.0万";
    NSDictionary *attri = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attri];
    self.priceL.attributedText = attriStr;
    [self.cellImage setImage:[UIImage imageNamed:@"pic_1.jpeg"]];
}

@end
