//
//  YLButtonView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLButtonView.h"

@interface YLButtonView ()

@property (nonatomic, strong) NSString *selectBtnTitle;

@end

@implementation YLButtonView

- (instancetype)initWithFrame:(CGRect)frame btnTitles:(NSArray *)btnTitles {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        float width = frame.size.width / 4;
        float height = frame.size.height / 3;
        for (int i = 0; i < btnTitles.count; i++) {
            int row = i / 4;
            int line = i % 4;
            UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            searchBtn.frame = CGRectMake(line * width, row * height, width, height);
            [searchBtn setTitle:btnTitles[i] forState:UIControlStateNormal];
            [searchBtn setTitleColor:YLColor(116.f, 116.f, 116.f) forState:UIControlStateNormal];
            searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            searchBtn.tag = 100 + i;
            [searchBtn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:searchBtn];
//            NSLog(@"%@-%@", self, searchBtn);
        }
    }
    return self;
}

- (void)selectBtn:(UIButton *)sender {
    
//    NSLog(@"selectBtn:按钮被点击le");
    self.selectBtnTitle = sender.titleLabel.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectBtnTitle:)]) {
        [self.delegate selectBtnTitle:self.selectBtnTitle];
    }
}

@end
