//
//  YLMineHeader.h
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLFunctionView.h"
#import "YLLoginHeader.h"
#import "YLMineIcon.h"

typedef NS_ENUM(NSInteger, YLLoginStatus) {
    YLLoginStatusDown,
    YLLoginStatusUp,
};

@interface YLMineHeader : UIView

@property (nonatomic, strong) YLFunctionView *fun;
@property (nonatomic, strong) YLLoginHeader *loginHeader;
@property (nonatomic, strong) YLMineIcon *mineIcon;
@property (nonatomic, assign) YLLoginStatus status;

@end
