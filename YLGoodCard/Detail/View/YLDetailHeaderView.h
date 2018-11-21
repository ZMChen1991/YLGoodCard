//
//  YLDetailHeaderView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLCondition.h"
#import "YLDetailHeaderModel.h"

@interface YLDetailHeaderView : UIView

@property (nonatomic, strong) YLCondition *bargain;// 砍价
@property (nonatomic, strong) YLDetailHeaderModel *model;

@end
