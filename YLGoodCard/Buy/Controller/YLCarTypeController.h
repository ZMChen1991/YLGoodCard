//
//  YLCarTypeController.h
//  YLGoodCard
//
//  Created by lm on 2018/11/23.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSeriesModel.h"
#import "YLBrandModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLCarTypeController : UITableViewController

@property (nonatomic, strong) YLSeriesModel *seriesModel;
@property (nonatomic, strong) YLBrandModel *brandModel;
@end

NS_ASSUME_NONNULL_END
