//
//  YLSaleTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/22.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSaleTool.h"

@implementation YLSaleTool

+ (void)saleWithParam:(id)param success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    NSString *urlString = @"http://ucarjava.bceapp.com/sell?method=order";
    [self getWithUrl:urlString param:param dictForResultClass:[NSDictionary class] success:success failure:failure];
    
}

+ (void)detectDetailWithParam:(id)param success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/center?method=id";
    [self getWithUrl:urlString param:param arrayForResultClass:[NSDictionary class] success:success failure:failure];
}


+ (void)cityDetectWithParam:(id)param success:(void (^)(NSArray * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/center?method=city";
    [self getWithUrl:urlString param:param arrayForResultClass:[NSDictionary class] success:success failure:failure];
}

@end
