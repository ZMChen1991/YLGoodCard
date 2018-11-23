//
//  YLBrandTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/16.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBaseTool.h"
#import "YLBrandModel.h"
#import "YLSeriesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBrandTool : YLBaseTool

/**
 获取车辆品牌数据

 @param param 参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)brandWithParam:(id)param success:(void (^)(NSArray<YLBrandModel *> *result))success failure:(void (^)(NSError * error))failure;

/**
 获取车辆品牌数据
 
 @param param 参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)SeriesWithParam:(id)param success:(void (^)(NSArray<YLSeriesModel *> *result))success failure:(void (^)(NSError * error))failure;
@end

NS_ASSUME_NONNULL_END
