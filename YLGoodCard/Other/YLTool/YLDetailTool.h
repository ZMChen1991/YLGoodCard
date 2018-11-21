//
//  YLDetailTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBaseTool.h"
#import "YLDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLDetailTool : YLBaseTool

///**
// 获取车辆详情
//
// @param param 车辆的参数，如id=100006
// @param success 请求成功后的回调
// @param failure 请求失败后的回调
//*/
//+ (void)getWithUrl:(NSString *)url param:(id)param success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

/**
 获取车辆详情
 
 @param param 车辆的参数，如id=100006
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)detailWithParam:(id)param success:(void (^)(YLDetailModel *result))success failure:(void (^)(NSError * _Nonnull))failure;

@end

NS_ASSUME_NONNULL_END
