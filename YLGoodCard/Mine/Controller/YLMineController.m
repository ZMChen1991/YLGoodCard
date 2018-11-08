//
//  YLMineController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLMineController.h"
#import "YLTableViewCell.h"

#import "YLCustomPrice.h"

//1. 对于约束参数可以省去"mas_"
#define MAS_SHORTHAND
//2. 对于默认的约束参数自动装箱
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height

@interface YLMineController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation YLMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"消息" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    
    YLCustomPrice *view = [[YLCustomPrice alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 400)];
    
    [self.view addSubview:view];
    
}


#pragma mark UITableViewDataSource/UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLTableViewCell *cell = [YLTableViewCell cellWithTableView:tableView];
    cell.cellModel = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 140;
}

- (void)rightBarButtonItemClick {
    NSLog(@"消息被点击了");
}
@end
