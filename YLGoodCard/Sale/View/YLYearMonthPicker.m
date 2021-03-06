//
//  YLYearMonthPicker.m
//  YLYouka
//
//  Created by lm on 2018/12/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//


#import "YLYearMonthPicker.h"
#import "YLCondition.h"

#define YLPICKERHEIGHT 40
#define YLPICKERWIDTH self.frame.size.width / 4

@interface YLYearMonthPicker () <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    NSString *selectYear;
    NSString *selectMonth;
}

@property (nonatomic, strong) UIPickerView *yearPicker;
@property (nonatomic, strong) UIPickerView *monthPicker;

@property (nonatomic, strong) NSMutableArray *years;
@property (nonatomic, strong) NSMutableArray *months;

@end

@implementation YLYearMonthPicker

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
//        selectYear = [self.years objectAtIndex:0];
//        selectMonth = [self.months objectAtIndex:0];
//        NSString *time = [NSString stringWithFormat:@"%@-%@", selectYear, selectMonth];
//        NSLog(@"%@", time);
        
    }
    return self;
}

- (void)setupUI {
    
    CGFloat height = 100;
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, YLPICKERWIDTH, height)];
    picker.delegate = self;
    picker.dataSource = self;
    [self addSubview:picker];
    self.yearPicker = picker;
    NSInteger yearRow = self.years.count - 1;
    [self.yearPicker selectRow:yearRow inComponent:0 animated:YES];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picker.frame), 0, YLPICKERWIDTH, height)];
    label1.text = @"年";
    label1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label1];

    UIPickerView *picker1 = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 0, YLPICKERWIDTH, height)];
    picker1.delegate = self;
    picker1.dataSource = self;
    [self addSubview:picker1];
    self.monthPicker = picker1;
    NSInteger monthRow = [self currentMonth] - 1;
    [self.monthPicker selectRow:monthRow inComponent:0 animated:YES];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(picker1.frame), 0, YLPICKERWIDTH, height)];
    label2.text = @"月";
    label2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label2];
    
    YLCondition *cancelBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, height + YLLeftMargin, YLScreenWidth / 2, 40);
    cancelBtn.type = YLConditionTypeWhite;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    YLCondition *sureBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(YLScreenWidth / 2, height + YLLeftMargin, YLScreenWidth / 2, 40);
    sureBtn.type = YLConditionTypeWhite;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    
}

- (void)cancelClick {
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)sureClick {
    
    NSString *time = [NSString stringWithFormat:@"%@-%@", selectYear, selectMonth];
    if (self.sureBlock) {
        self.sureBlock(time);
    }
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.yearPicker) {
        return self.years.count;
    } else {
        return self.months.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return YLPICKERHEIGHT;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YLPICKERWIDTH, YLPICKERHEIGHT)];
    title.textAlignment = NSTextAlignmentCenter;
    if (pickerView == self.yearPicker) {
        title.text = self.years[row];
    }  else {
        title.text = self.months[row];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.yearPicker == pickerView) {
        selectYear = [self.years objectAtIndex:row];
    }if (self.monthPicker == pickerView) {
        selectMonth = [self.months objectAtIndex:row];
    }
    
//    NSString *time = [NSString stringWithFormat:@"%@-%@", selectYear, selectMonth];
//    if (self.YearMonthBlock) {
//        self.YearMonthBlock(time);
//    }
}

// 当前年份
- (NSInteger)currentYear {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY"];
    return [[dateFormatter stringFromDate:[NSDate date]] integerValue];
}
- (NSInteger)currentMonth {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    return [[dateFormatter stringFromDate:[NSDate date]] integerValue];
}

- (NSMutableArray *)years {
    if (!_years) {
        _years = [NSMutableArray array];
        NSInteger totalYear = [self currentYear];
        for (NSInteger i = totalYear - 50; i < totalYear + 1; i++) {
            [_years addObject:[NSString stringWithFormat:@"%ld", i]];
        }
        selectYear = [_years lastObject];
    }
    return _years;
}

- (NSMutableArray *)months {
    if (!_months) {
        _months = [NSMutableArray array];
        for (NSInteger i = 1; i < 13; i++) {
            [_months addObject:[NSString stringWithFormat:@"%ld", i]];
        }
        NSInteger index = [self currentMonth] - 1;
        selectMonth = [_months objectAtIndex:index];
    }
    return _months;
}

@end
