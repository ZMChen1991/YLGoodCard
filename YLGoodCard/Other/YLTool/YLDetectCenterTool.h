//
//  YLDetectCenterTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBaseTool.h"
#import "YLDetectCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLDetectCenterTool : YLBaseTool


/**
 获取检测中心的数据

 @param param 参数：如城市或者地区  city=阳江
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)detectCenterWithParam:(id)param success:(void (^)(NSArray<YLDetectCenterModel *> *result))success failure:(void (^)(NSError * error))failure;

@end

NS_ASSUME_NONNULL_END
