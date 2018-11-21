//
//  YLDetailFooterView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLCondition.h"

typedef void(^DetailFooterBlock)(UIButton *sender);

@interface YLDetailFooterView : UIView

@property (nonatomic, strong) YLCondition *bargain;
@property (nonatomic, strong) YLCondition *order;
@property (nonatomic, copy) DetailFooterBlock detailFooterBlock;
@property (nonatomic, assign) BOOL isFavorite;

@end
