//
//  YLCarTypeController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/23.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCarTypeController.h"
#import "YLBuyTool.h"
#import "YLRequest.h"

@interface YLCarTypeController ()

@property (nonatomic, strong) NSMutableArray *carTypes;// 车型数组

@end

@implementation YLCarTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self loadData];
}

- (void)loadData {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = self.seriesModel.seriesId;
    [YLBuyTool carTypeWithParam:param success:^(NSArray<YLCarTypeModel *> * _Nonnull result) {
        for (YLCarTypeModel *model in result) {
            [self.carTypes addObject:model];
        }
        YLCarTypeModel *model = [[YLCarTypeModel alloc] init];
        model.name = @"不限";
        model.ID = @"0000";
        if (!self.carTypes.count) {
            [self.carTypes addObject:model];
        } else {
            [self.carTypes insertObject:model atIndex:0];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carTypes.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"Cell";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    YLCarTypeModel *model = self.carTypes[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLCarTypeModel *model = self.carTypes[indexPath.row];
    NSLog(@"%@-%@-%@", self.brandModel.brand, self.seriesModel.series, model.name);
}

- (NSMutableArray *)carTypes {
    
    if (!_carTypes) {
        _carTypes = [NSMutableArray array];
    }
    return _carTypes;
}

@end
