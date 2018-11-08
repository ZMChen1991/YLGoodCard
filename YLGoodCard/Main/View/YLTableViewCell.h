//
//  YLTableViewCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLCellModel.h"

typedef NS_ENUM(NSInteger, YLTableViewCellType) {
    YLTableViewCellTypeSmallImage,
    YLTableViewCellTypeLargeImage,
};

@interface YLTableViewCell : UITableViewCell

@property (nonatomic, strong) YLCellModel *cellModel;
@property (nonatomic, assign) YLTableViewCellType type;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
