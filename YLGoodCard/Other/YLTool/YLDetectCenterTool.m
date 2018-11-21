//
//  YLDetectCenterTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetectCenterTool.h"

@implementation YLDetectCenterTool

+ (void)detectCenterWithParam:(id)param success:(void (^)(NSArray<YLDetectCenterModel *> *result))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/center?method=city&city=%E9%98%B3%E6%B1%9F";
    [self getWithUrl:urlString param:param arrayForResultClass:[YLDetectCenterModel class] success:success failure:failure];
}

@end
