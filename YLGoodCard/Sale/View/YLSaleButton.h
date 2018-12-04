//
//  YLSaleButton.h
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLSaleButton;

@protocol YLSaleButtonDelegate <NSObject>

- (void)pushController:(YLSaleButton *)sender;

@end

@interface YLSaleButton : UIButton

@property (nonatomic, weak) id<YLSaleButtonDelegate> delegate;

@end
