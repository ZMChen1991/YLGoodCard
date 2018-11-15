//
//  YLRotateTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBaseTool.h"
#import "YLBannerModel.h"
#import "YLNotableModel.h"
#import "YLTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLRotateTool : YLBaseTool


/**
 加载轮转图信息

 @param param 请求参数
 @param success 请求成功后的回调（应该回调模型，而不是类，这里需要修改）
 @param failure 请求失败后的回调
 */
+ (void)bannerWithParam:(id)param success:(void(^)(NSArray<YLBannerModel *> *result))success failure:(void (^)(NSError *error))failure;

/**
 加载走马灯广告信息（用户成交信息）
 
 @param param 请求参数
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)notableWithParam:(id)param success:(void(^)(NSArray<YLNotableModel *> *result))success failure:(void (^)(NSError *error))failure;


+ (void)recommendWithParam:(id)param success:(void(^)(NSArray<YLTableViewModel *> *result))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
