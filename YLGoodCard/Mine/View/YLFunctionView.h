//
//  YLFunctionView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLFunctionView;

@protocol YLFunctionViewDelegate <NSObject>

@optional
- (void)btnClickToController:(UIButton *)sender;
- (void)callTelephone;
- (void)suggestions;

@end

@interface YLFunctionView : UIView

@property (nonatomic, weak) id<YLFunctionViewDelegate> delegate;

@end
