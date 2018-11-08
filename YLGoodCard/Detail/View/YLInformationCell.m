//
//  YLInformationCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLInformationCell.h"

@interface YLInformationCell ()

@property (nonatomic, strong) UIView *labelView;

@end

@implementation YLInformationCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    
    static NSString *ID = @"cellID";
    YLInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLInformationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
//        NSLog(@"%@", self);
    }
    return self;
}

- (void)setupUI {
    
    NSArray *array = @[@"表显里程", @"上牌时间", @"车牌所在地", @"看车地点", @"排放量", @"迁入地为准", @"变速箱", @"登记证为准", @"年检到期", @"商业险到期", @"交强险到期"];
    NSArray *array1 = @[@"12.8公里", @"2015-10-10", @"阳江", @"阳东", @"1.8", @"国五", @"自动", @"0次过户", @"2019.08", @"2019.08", @"2019.08"];
    
    NSUInteger count = array.count;
    for (int i = 0 ; i < count; i++) {
        int row = i / 2;
        int line = i % 2;
        float width = (self.frame.size.width - 2 * YLLeftMargin) / 2;
        float height = 30;
        CGRect frame = CGRectMake(line * width, row * height, width, height);
        UIView *view = [self setupTitle:array[i] subtitle:array1[i] frame:frame];
        [self.labelView addSubview:view];
    }
}

- (UIView *)labelView {
    if (!_labelView) {
        CGRect frame = CGRectMake(YLLeftMargin, 0, self.frame.size.width - 2 * YLLeftMargin, 180);
        _labelView = [[UIView alloc] initWithFrame:frame];
//        _labelView.backgroundColor = [UIColor redColor];
        [self addSubview:_labelView];
    }
    return _labelView;
}

- (UIView *)setupTitle:(NSString *)title subtitle:(NSString *)subtitle frame:(CGRect)frame {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 65, view.frame.size.height)];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = YLColor(155.f, 155.f, 155.f);
    label1.text = title;
    label1.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, view.frame.size.width - 65 - 10, view.frame.size.height)];
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = YLColor(51.f, 51.f, 51.f);
    label2.text = subtitle;
    label2.textAlignment = NSTextAlignmentRight;
    [view addSubview:label2];
    return view;
}

- (float)height {
    return 180;
}

// cell获取的宽不对，这里重设宽
- (void)setFrame:(CGRect)frame {
    frame.size.width = YLScreenWidth;
    [super setFrame:frame];
}

@end
