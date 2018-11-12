//
//  YLHeaderView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLHeaderView.h"

#import "YLTableHeaderModel.h"


@interface YLHeaderView ()


@property (nonatomic, strong) UIView *btnView; // 按钮集合视图



@end

@implementation YLHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        float width = self.frame.size.width;
        float height = self.frame.size.height;
        float rotateX = 0;
        float rotateY = 0;
        float rotateW = width;
        float rotateH = height - 100 - 44 - YLMargin;
        self.pictureRotate = [[PictureRotate alloc] init];
        self.pictureRotate.frame = CGRectMake(rotateX, rotateY, rotateW, rotateH);
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, rotateH, rotateW, 1)];
        line.backgroundColor = YLColor(233.f, 233.f, 233.f);
        [self.pictureRotate addSubview:line];
        
        [self addSubview:self.pictureRotate];
        [self addSubview:self.menuView];
        [self addSubview:self.btnView];
    
        
        [self createMenu];
        
        
        [self createBtn];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

- (void)createMenu {
    
    YLTableHeaderModel *model = [[YLTableHeaderModel alloc] init];
    model.title = @"热门二手车";
    model.subtitle = @"查看更多";
//    model.icon = @"www";
    
    float width = self.frame.size.width;
    float menuX = 0;
    float menuY = CGRectGetMaxY(self.pictureRotate.frame);
    float menuW = width;
    float menuH = 44;
    self.menuView.frame = CGRectMake(menuX, menuY, menuW, menuH);
    self.menuView.tableHeadertype = YLTableHeaderTypeSubtitle;
    self.menuView.tableHeaderModel = model;
    
//    float labelW = self.frame.size.width / 4;
//    float LabelH = CGRectGetHeight(self.menuView.frame);
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelW, LabelH)];
//    label.text = @"热门二手车";
//    label.textAlignment = NSTextAlignmentCenter;
//    [self.menuView addSubview:label];
//
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(labelW * 3, 0, labelW, LabelH);
//    [btn setTitle:@"查看全部" forState:UIControlStateNormal];
//    [btn setTitleColor:YLColor(102.f, 102.f, 102.f) forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.menuView addSubview:btn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, menuH, self.frame.size.width, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self.menuView addSubview:line];
}

- (void)createBtn {
    
    float width = self.frame.size.width;
//    float height = self.frame.size.height;
    
    float btnViewX = 0;
    float btnViewY = CGRectGetMaxY(self.menuView.frame);
    float btnViewW = width;
    float btnViewH = 100;
    self.btnView.frame = CGRectMake(btnViewX, btnViewY, btnViewW, btnViewH);
    
    NSArray *array = [NSArray arrayWithObjects:@"5万以下", @"5-10万", @"10-15万", @"15万以上", @"哈弗", @"丰田",@"大众", @"本田", @"力帆", @"日产", @"雪佛兰", @"更多", nil];
    float btnW = self.frame.size.width / 4;
    float btnH = btnViewH / 3;
    for (int i = 0; i < array.count; i++) {
        int row = i / 4;
        int line = i % 4;
        UIButton *choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        choiceBtn.frame = CGRectMake(line * btnW, row * btnH, btnW, btnH);
        [choiceBtn setTitle:array[i] forState:UIControlStateNormal];
        [choiceBtn setTitleColor:YLColor(116.f, 116.f, 116.f) forState:UIControlStateNormal];
        choiceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [choiceBtn addTarget:self action:@selector(choiceBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnView addSubview:choiceBtn];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, btnViewH, width, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self.btnView addSubview:line];
}

- (void)choiceBtn:(UIButton *)sender {
    
    NSLog(@"%@", sender.titleLabel.text);
    if (self.delegate && [self.delegate respondsToSelector:@selector(choiceBrand:)]) {
        [self.delegate choiceBrand:sender];
    }
}

#pragma mark -懒加载
- (YLTableHeaderView *)menuView {
    
    if ((!_menuView)) {
        _menuView = [[YLTableHeaderView alloc] init];
    }
    return _menuView;
}

- (UIView *)btnView {
    
    if ((!_btnView)) {
        _btnView = [[UIView alloc] init];
    }
    return _btnView;
}
@end
