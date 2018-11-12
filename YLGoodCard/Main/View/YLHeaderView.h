//
//  YLHeaderView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureRotate.h"
#import "YLTableHeaderView.h"

@class YLHeaderView;
@protocol YLHeaderViewDelegate <NSObject>

- (void)choiceBrand:(UIButton *)sender;

@end

@interface YLHeaderView : UIView

@property (nonatomic, strong) PictureRotate *pictureRotate; // 转播图
@property (nonatomic, strong) YLTableHeaderView *menuView; // 栏目

@property (nonatomic, weak) id<YLHeaderViewDelegate> delegate;

@end
