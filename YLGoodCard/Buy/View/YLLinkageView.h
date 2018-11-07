//
//  YLLinkageView.h
//  仿美团菜单栏
//
//  Created by lm on 2017/5/26.
//  Copyright © 2017年 CocaCola. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLLinkageView;

@protocol YLLinkageViewDelegate <NSObject>

- (void)pushController:(YLLinkageView *)linkageView;

@end

@interface YLLinkageView : UIView

@property (nonatomic, copy) id<YLLinkageViewDelegate> delegate;

@end
