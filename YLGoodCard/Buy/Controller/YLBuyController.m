//
//  YLBuyController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBuyController.h"
#import "YLTitleButton.h"

@interface YLBuyController ()

@end

@implementation YLBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNav {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"阳江" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    YLTitleButton *titleBtn = [[YLTitleButton alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [titleBtn setTitle:@"    搜索您想要的车   " forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.backgroundColor = [UIColor grayColor];
    self.navigationItem.titleView = titleBtn;
}

- (void)titleClick {
    
    NSLog(@"title被点击了！");
}

- (void)leftBarButtonItemClick {
    
    NSLog(@"leftBarButtonItem被点击了！");
}

- (void)rightBarButtonItemClick {
    
    NSLog(@"rightBarButtonItem被点击了！");
}
@end
