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
@property (nonatomic, strong) NSMutableArray *labels;

@end

@implementation YLInformationCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    
    static NSString *ID = @"YLInformationCell";
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
    }
    return self;
}

- (void)setupUI {
    
    NSArray *array = @[@"表显里程", @"上牌时间", @"车牌所在地", @"看车地点", @"排放量", @"环保标准", @"变速箱", @"登记证为准", @"年检到期", @"商业险到期", @"交强险到期"];
//    NSArray *array1 = @[@"12.8公里", @"2015-10-10", @"阳江", @"阳东", @"1.8", @"国五", @"自动", @"0次过户", @"2019.08", @"2019.08", @"2019.08"];
    NSUInteger count = array.count;
    for (int i = 0 ; i < count; i++) {
        int row = i / 2;
        int line = i % 2;
        float width = (self.frame.size.width - 2 * YLLeftMargin) / 2;
        float height = 30;
        CGRect frame = CGRectMake(line * width, row * height, width, height);
        UIView *view = [self setupTitle:array[i] subtitle:nil frame:frame];
        [self.labelView addSubview:view];
    }
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 211)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bg.frame), self.frame.size.width, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [bg addSubview:line];
    [bg addSubview:self.labelView];
    [self addSubview:bg];
    
}

- (UIView *)labelView {
    if (!_labelView) {
        CGRect frame = CGRectMake(YLLeftMargin, YLLeftMargin, self.frame.size.width - 2 * YLLeftMargin, 180);
        _labelView = [[UIView alloc] initWithFrame:frame];
    }
    return _labelView;
}

- (UIView *)setupTitle:(NSString *)title subtitle:(NSString *)subtitle frame:(CGRect)frame {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
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
    [self.labels addObject:label2];
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

- (NSMutableArray *)labels {
    if (!_labels) {
        _labels = [NSMutableArray array];
    }
    return _labels;
}

- (void)setModel:(YLDetailInfoModel *)model {
    
    _model = model;
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:model.course];
    [array addObject:model.licenseTime];
    [array addObject:model.location];
    [array addObject:model.meetingPlace];
    [array addObject:model.emission];
    [array addObject:model.emissionStandard];
    [array addObject:model.gearbox];
    [array addObject:model.transfer];
    [array addObject:model.annualInspection];
    [array addObject:model.commercialInsurance];
    [array addObject:model.trafficInsurance];

    for (NSInteger i = 0; i < array.count; i++) {
        if (array[i] == nil) {
            break;
        }
        UILabel *label = self.labels[i];
        label.text = array[i];
    }
}

@end
