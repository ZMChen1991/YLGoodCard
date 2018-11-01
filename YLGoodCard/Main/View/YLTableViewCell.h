//
//  YLTableViewCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLCellModel.h"

@interface YLTableViewCell : UITableViewCell

@property (nonatomic, strong) YLCellModel *cellModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
