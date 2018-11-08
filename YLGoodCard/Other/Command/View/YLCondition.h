//
//  YLCondition.h
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YLConditionType) {
    YLConditionTypeBlue,        // 白底蓝字
    YLConditionTypeWhite,       // 蓝底白字
    YLConditionTypeGray,        // 灰底白字
};

@interface YLCondition : UIButton

@property (nonatomic, assign) YLConditionType type;

@end
