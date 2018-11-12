//
//  YLSafeguardCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSafeguardCell.h"

@interface YLSafeguardCell ()

@property (nonatomic, strong) UIButton *btn;// 服务保障
@property (nonatomic, strong) UIImageView *provideView;

@end

@implementation YLSafeguardCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    
    static NSString *ID = @"YLSafeguardCell";
    YLSafeguardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLSafeguardCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor greenColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    NSArray *array = @[@"售后保障", @"30天可退", @"调表车赔付", @"禁售抢盗车"];
    float width = (self.frame.size.width - 2 * YLLeftMargin) / array.count;
    float height = 80;
    for (int i = 0; i < array.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * width + YLLeftMargin, 0, width, height)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:YLRandomColor];
        [self addSubview:btn];
    }
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(YLLeftMargin, height, self.frame.size.width - 2 * YLLeftMargin, height)];
    image.backgroundColor = [UIColor redColor];
    [self addSubview:image];
    self.provideView = image;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame) + YLLeftMargin, self.frame.size.width, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
}

- (void)btnClick {
    NSLog(@"click");
    self.provideView.backgroundColor = YLRandomColor;
}

- (float)height {
    return 160;
}

// cell获取的宽不对，这里重设宽
- (void)setFrame:(CGRect)frame {
    frame.size.width = YLScreenWidth;
    [super setFrame:frame];
}

@end