//
//  YLLoginHeader.h
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLLoginHeader;

@protocol YLLoginHeaderDelegate <NSObject>

@optional
- (void)skipToLogin;

@end

typedef NS_ENUM(NSInteger, YLLoginStatus) {
    
    YLLoginStatusUp, // 已登录
    YLLoginStatusDown,// 没登录
};

@interface YLLoginHeader : UIView

@property (nonatomic, assign) YLLoginStatus status;
@property (nonatomic, weak) id<YLLoginHeaderDelegate> delegate;

@end
