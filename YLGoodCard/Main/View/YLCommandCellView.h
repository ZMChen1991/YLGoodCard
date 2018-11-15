//
//  YLCommandCellView.h
//  YLYouka
//
//  Created by lm on 2018/11/14.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLCommandCellView : UIView

@property (nonatomic, strong) YLTableViewModel *model;

@end

NS_ASSUME_NONNULL_END
