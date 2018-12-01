//
//  YLLicenseTime.m
//  YLGoodCard
//
//  Created by lm on 2018/11/27.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLLicenseTime.h"
#import "YLCondition.h"
#import "YLYearMonthPicker.h"

@interface YLLicenseTime ()

@property (nonatomic, strong) NSString *yearMonth;

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
    
    CGFloat height = 80;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, YLLeftMargin, YLScreenWidth, height)];
    [self addSubview:view];
    
    YLYearMonthPicker *picker = [[YLYearMonthPicker alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, height)];
//    picker.YearMonthBlock = ^(NSString * _Nonnull yearMonth) {
//        NSLog(@"%@", yearMonth);
//        self.yearMonth = yearMonth;
//    };
    [view addSubview:picker];
    
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
}

- (void)sureClick {
    
    NSLog(@"点击确定");

    if (self.sureBlock) {
        self.sureBlock(self.yearMonth);
    }
}


@end
