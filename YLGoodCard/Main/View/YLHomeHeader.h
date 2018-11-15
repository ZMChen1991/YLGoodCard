//
//  YLHomeHeader.h
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLButtonView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLHomeHeader : UIView

@property (nonatomic, strong) YLButtonView *buttonView;

- (instancetype)initWithFrame:(CGRect)frame bannerTitles:(NSMutableArray *)bannerTitles notabletitles:(NSMutableArray *)notabletitles;

@end

NS_ASSUME_NONNULL_END
