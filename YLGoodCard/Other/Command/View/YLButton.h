//
//  YLButton.h
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLButton;
@protocol YLButtonDelegate <NSObject>

- (void)checkMore;

@end

@interface YLButton : UIButton

@property (nonatomic, copy) id<YLButtonDelegate> delegate;

@end
