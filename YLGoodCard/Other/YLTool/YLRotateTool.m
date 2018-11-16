//
//  YLRotateTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLRotateTool.h"

@implementation YLRotateTool

+ (void)bannerWithParam:(id)param success:(void (^)(NSArray<YLBannerModel *> *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *url = @"http://ucarjava.bceapp.com/home?method=play";
    [self getWithUrl:url param:param resultClass:[YLBannerModel class] success:success failure:failure];
}

+ (void)notableWithParam:(id)param success:(void (^)(NSArray<YLNotableModel *> *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *url = @"http://ucarjava.bceapp.com/trade?method=random";
    [self getWithUrl:url param:param resultClass:[YLNotableModel class] success:success failure:failure];
//    NSLog(@"%@",success);
}

+ (void)recommendWithParam:(id)param success:(void (^)(NSArray<YLTableViewModel *> *result))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *url = @"http://ucarjava.bceapp.com/detail?method=recommend";
    [self getWithUrl:url param:param resultClass:[YLTableViewModel class] success:success failure:failure];
}

@end
