//
//  YLManager.h
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLUser.h"

@interface YLManager : NSObject

YLSingletonH;

@property (nonatomic, readonly) YLUser *user; // 用户信息
@property (nonatomic, assign) BOOL isLogin; // 是否登录

// 用户登录
- (void)loginWithUser:(YLUser *)user;
// 用户退出
- (void)logout;

@end
