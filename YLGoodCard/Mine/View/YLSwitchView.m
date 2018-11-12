//
//  YLSwitchView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#define titleHeight 50
#define titleCount 2

#import "YLSwitchView.h"

@interface YLSwitchView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, strong) UIView *slideView;
//@property (nonatomic, strong) UIScrollView *titleScroll;
@property (nonatomic, strong) UIScrollView *controllerScroll;
@property (nonatomic, strong) NSMutableArray<UIButton *> *btns;

@end

@implementation YLSwitchView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        [self setupUI];
    }
    return self;
}

- (void)setupTitleView:(NSArray *)titles {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    float width = self.frame.size.width / titles.count;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(width * i, 0, width, titleHeight);
        [btn setTitleColor:YLColor(51.f, 51.f, 51.f) forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 100 + i;
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(selectToIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self.btns addObject:btn];
        [view addSubview:btn];
        if (i == 0) {
            self.selectBtn = btn;
            [self.selectBtn setTitleColor:YLColor(8.f, 169.f, 255.f) forState:UIControlStateNormal];
        }
    }
    UIView *slider = [[UIView alloc] initWithFrame:CGRectMake(0, titleHeight-1, width, 1)];
    slider.backgroundColor = YLColor(8.f, 169.f, 255.f);
    [view addSubview:slider];
    [self addSubview:view];
    self.slideView = slider;
    self.btnView = view;
}

- (void)setupScrollView:(NSArray *)controllers {
    
    CGFloat scrollY = CGRectGetMaxY(self.btnView.frame);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollY, self.frame.size.width, self.frame.size.height)];
    //    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.frame.size.width * controllers.count, self.frame.size.height);
    [self addSubview:scrollView];
    self.controllerScroll = scrollView;
    
    //待修改
    for (NSInteger i = 0; i < controllers.count; i++) {
        UIView *controllerView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
        UIViewController *controller = self.controllers[i];
        controllerView = controller.view;
        [self.controllerScroll addSubview:controllerView];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (void)selectToIndex:(UIButton *)sender {
    
    NSLog(@"点击了第%ld个按钮", sender.tag - 100);
    NSInteger i = sender.tag - 100;
    [UIView animateWithDuration:0.3 animations:^{
        self.controllerScroll.contentOffset = CGPointMake(self.frame.size.width * i, 0);
    }];
}

- (void)selectBtn:(NSInteger)index {
    
    // 如果选中其他的按钮，默认按钮恢复到原来的字体
    [self.selectBtn setTitleColor:YLColor(51.f, 51.f, 51.f) forState:UIControlStateNormal];
    // 设置选中的按钮
    self.selectBtn = self.btns[index];
    [self.selectBtn setTitleColor:YLColor(8.f, 169.f, 255.f) forState:UIControlStateNormal];
    
    NSInteger width = self.frame.size.width / self.titles.count;
    CGRect sliderRect = self.slideView.frame;
    sliderRect.origin.x = width * index;
    [UIView animateWithDuration:0.1 animations:^{
        // 设置滑片位置
        self.slideView.frame = sliderRect;
//        self.controllerScroll.contentOffset = CGPointMake(self.frame.size.width * index, 0);
    }];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//
//}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//
//    CGPoint contentOffSet = self.controllerScroll.contentOffset;
//    NSInteger index = contentOffSet.x / self.frame.size.width;
//    [self selectBtn:index];
//}


- (NSMutableArray<UIButton *> *)btns {
    
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)setTitles:(NSArray *)titles {
    
    _titles = titles;
    [self setupTitleView:titles];
}

- (void)setControllers:(NSArray *)controllers {
    
    _controllers = controllers;
    [self setupScrollView:controllers];
}

@end
