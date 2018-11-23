//
//  YLBrandTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/16.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBrandTool.h"

@implementation YLBrandTool
//http://ucarjava.bceapp.com/vehicle?method=brand

+ (void)brandWithParam:(id)param success:(void (^)(NSArray<YLBrandModel *> *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *url = @"http://ucarjava.bceapp.com/vehicle?method=brand";
    [self getWithUrl:url param:param arrayForResultClass:[YLBrandModel class] success:success failure:failure];
    
}

+ (void)SeriesWithParam:(id)param success:(void (^)(NSArray<YLSeriesModel *> * result))success failure:(void (^)(NSError * error))failure {
    
    NSString *url = @"http://ucarjava.bceapp.com/vehicle?method=series";
    [self getWithUrl:url param:param arrayForResultClass:[YLSeriesModel class] success:success failure:failure];
}

@end
