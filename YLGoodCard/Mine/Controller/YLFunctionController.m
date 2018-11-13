//
//  YLFunctionController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLFunctionController.h"
#import "YLSubController.h"

@interface YLFunctionController ()

@end

@implementation YLFunctionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *titles = @[@"我是买家", @"我是卖家"];
    self.skip.titles = titles;
    NSMutableArray *ctrs = [NSMutableArray array];
    for (NSInteger i = 0; i < titles.count; i++) {
        YLSubController *ctr1 = [[YLSubController alloc] init];
        ctr1.cellType = YLCellTypeBargain;
        [ctrs addObject:ctr1];
    }
    self.skip.controllers = ctrs;
    [self.view addSubview:_skip];
}

- (YLSkipView *)skip {
    
    if (!_skip) {
        _skip = [[YLSkipView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    }
    return _skip;
}

@end
