//
//  YLBrandTool.h
//  YLGoodCard
//
//  Created by lm on 2018/11/16.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBaseTool.h"
#import "YLBrandModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBrandTool : YLBaseTool

+ (void)brandWithParam:(id)param success:(void (^)(NSArray<YLBrandModel *> *result))success failure:(void (^)(NSError * error))failure;
@end

NS_ASSUME_NONNULL_END
