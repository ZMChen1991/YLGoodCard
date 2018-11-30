//
//  YLLicenseTime.m
//  YLGoodCard
//
//  Created by lm on 2018/11/27.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLLicenseTime.h"
#import "YLCondition.h"

@interface YLLicenseTime ()

//@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextField *month;
@property (nonatomic, strong) UITextField *day;
@property (nonatomic, strong) UITextField *hour;
@property (nonatomic, strong) UITextField *minute;

@end

@implementation YLLicenseTime

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGFloat width = 50;
    CGFloat height = 30;
    CGFloat labelW = 20;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((300 - 260) / 2, YLLeftMargin, 260, height)];
//    view.backgroundColor = [UIColor yellowColor];
    [self addSubview:view];
    // 月
    UITextField *month = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    month.textAlignment = NSTextAlignmentRight;
    month.placeholder = @"月份";
    [view addSubview:month];
    self.month = month;
    
    UILabel *monthL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(month.frame), 0, labelW, height)];
    monthL.text = @"月";
    monthL.textAlignment = NSTextAlignmentCenter;
    [view addSubview:monthL];
    // 日
    UITextField *day = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(monthL.frame), 0, width, height)];
    day.textAlignment = NSTextAlignmentRight;
    day.placeholder = @"日期";
    [view addSubview:day];
    self.day = day;
    
    UILabel *dayL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(day.frame), 0, labelW, height)];
    dayL.text = @"日";
    dayL.textAlignment = NSTextAlignmentCenter;
    [view addSubview:dayL];
    // 时
    UITextField *hour = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dayL.frame), 0, width, height)];
    hour.textAlignment = NSTextAlignmentRight;
    hour.placeholder = @"小时";
    [view addSubview:hour];
    self.hour = hour;
    
    UILabel *hourL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hour.frame), 0, labelW, height)];
    hourL.text = @":";
    hourL.textAlignment = NSTextAlignmentCenter;
    [view addSubview:hourL];
    // 分
    UITextField *minute = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hourL.frame), 0, width, height)];
    minute.placeholder = @"分钟";
    [view addSubview:minute];
    self.minute = minute;
    
    
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(YLLeftMargin, YLLeftMargin, self.frame.size.width-YLLeftMargin * 2, self.frame.size.height-70)];
//    textField.placeholder = @"请输入上牌时间 格式：YYYY-MM-dd";
//    [textField setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
//    textField.layer.borderWidth = 0.5;
//    textField.layer.borderColor = [UIColor grayColor].CGColor;
//    textField.clearsOnBeginEditing = YES;
//    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    [self addSubview:textField];
//    self.textField = textField;
    
    YLCondition *cancelBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(view.frame) + 15, self.frame.size.width / 2, 40);
    cancelBtn.type = YLConditionTypeWhite;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    YLCondition *sureBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(self.frame.size.width / 2, CGRectGetMaxY(view.frame) + 15, self.frame.size.width / 2, 40);
    sureBtn.type = YLConditionTypeWhite;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
}

- (void)cancelClick {
    NSLog(@"点击取消，清空文本框");
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    self.month.text = @"";
    self.day.text = @"";
    self.hour.text = @"";
    self.minute.text = @"";
}

- (void)sureClick {
    
    NSLog(@"点击确定");
    NSString *licenseTime = [NSString stringWithFormat:@"%@月%@日%@:%@", self.month.text, self.day.text, self.hour.text, self.minute.text];
    
    if (self.sureBlock) {
        self.sureBlock(licenseTime);
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

@end
