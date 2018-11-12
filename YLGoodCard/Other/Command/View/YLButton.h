//
//  YLButton.h
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, YLButtonType) {
//    YLButtonTypeRight, // 图片右
//    YLButtonTypeLeft, // 左
//    YLButtonTypeUp, // 上
//    YLButtonTypeDown,// 下
//};

@class YLButton;
@protocol YLButtonDelegate <NSObject>

- (void)checkMore;

@end

@interface YLButton : UIButton

@property (nonatomic, weak) id<YLButtonDelegate> delegate;

//@property (nonatomic, assign) YLButtonType type;

@end
