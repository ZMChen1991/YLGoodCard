//
//  YLSeriesController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSeriesController.h"
#import "YLBrandTool.h"
#import "YLSeriesModel.h"
#import "YLCarTypeController.h"


@interface YLSeriesController ()

@property (nonatomic, strong) NSArray *series;

@end

@implementation YLSeriesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择车系";
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = self.model.brandId;
    [YLBrandTool SeriesWithParam:param success:^(NSArray<YLSeriesModel *> * _Nonnull result) {
        self.series = result;
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.series.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"YLSeriesController";
    // 1.拿到一个标识先去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果缓存池中没有，才需要传入一个标识创新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    YLSeriesModel *model = self.series[indexPath.row];
    cell.textLabel.text = model.series;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSeriesModel *model = self.series[indexPath.row];
    YLCarTypeController *carType = [[YLCarTypeController alloc] init];
    carType.model = model;
    carType.navigationItem.title = @"选择车型";
    [self.navigationController pushViewController:carType animated:YES];
    NSLog(@"%@", model);
}


- (NSArray *)series {
    if (!_series) {
        _series = [NSArray array];
    }
    return _series;
}

@end
