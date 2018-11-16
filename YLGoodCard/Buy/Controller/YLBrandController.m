//
//  YLBrandController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBrandController.h"
#import "YLBrandTool.h"
#import "YLBrandModel.h"


@interface YLBrandController ()

@property (nonatomic, strong) NSMutableArray *brands;// 汽车品牌

@end

@implementation YLBrandController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {
    
    [YLBrandTool brandWithParam:nil success:^(NSArray<YLBrandModel *> * _Nonnull result) {
        for (YLBrandModel *model in result) {
            [self.brands addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.brands.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLBrandController";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    YLBrandModel *model = self.brands[indexPath.row];
    cell.textLabel.text = model.brand;
    return cell;
}


- (NSMutableArray *)brands {
    
    if (!_brands) {
        _brands = [NSMutableArray array];
    }
    return _brands;
}

@end
