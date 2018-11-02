//
//  YLHeaderView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLHeaderView.h"
#import "PictureRotate.h"

@interface YLHeaderView ()

@property (nonatomic, strong) UIView *menuView; // 栏目
@property (nonatomic, strong) UIView *btnView; // 按钮集合视图


@end

@implementation YLHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.btnView = [[UIView alloc] init];
        self.btnView.backgroundColor = [UIColor yellowColor];
        
        self.menuView = [[UIView alloc] init];
//        self.menuView.backgroundColor = [UIColor redColor];
 
#warning - 这里还需要添加转播图 2018.11.01
        [self addSubview:self.menuView];
        [self addSubview:self.btnView];
        
        [self createMenu];
        [self createBtn];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float width = self.frame.size.width;
    
    self.menuView.frame = CGRectMake(0, 0, width, 30);
    self.btnView.frame = CGRectMake(0, 30, self.frame.size.width, 90);
}

- (void)createMenu {
    
    float width = self.frame.size.width / 4;
    float height = 30;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    label.text = @"热门二手车";
    label.textAlignment = NSTextAlignmentCenter;
    [self.menuView addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.frame.size.width-width, 0, width, height);
    [btn setTitle:@"查看全部" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:btn];
}

- (void)createBtn {
    
    NSArray *array = [NSArray arrayWithObjects:@"5万以下", @"5-10万", @"10-15万", @"15万以上", @"哈弗", @"丰田",@"大众", @"本田", @"力帆", @"日产", @"雪佛兰", @"更多", nil];
    float btnW = self.frame.size.width / 4;
    float btnH = 30;
    for (int i = 0; i < array.count; i++) {
        int row = i / 4;
        int line = i % 4;
        NSLog(@"row:%d--line:%d", row, line);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(line * btnW, row * btnH, btnW, btnH);
        btn.backgroundColor = YLRandomColor;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnView addSubview:btn];
    }
}

- (void)btnClick {
    
    NSLog(@"btnClick:按钮被点击了");
}

- (void)click:(UIButton *)sender {
    
    NSLog(@"按钮被点击了");
}

@end
