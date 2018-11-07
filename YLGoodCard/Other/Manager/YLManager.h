//
//  YLManager.h
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLManagerInfo.h"

@interface YLManager : NSObject

YLSingletonH;

@property (nonatomic, strong) YLManagerInfo *managerInfo; // 用户信息
@property (nonatomic, assign) BOOL isLogin; // 是否登录



@end
