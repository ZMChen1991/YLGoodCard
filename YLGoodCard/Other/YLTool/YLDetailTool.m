//
//  YLDetailTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailTool.h"
#import "YLRequest.h"

@implementation YLDetailTool

+ (void)detailWithParam:(id)param success:(void (^)(YLDetailModel *result))success failure:(void (^)(NSError * error))failure {
    
    NSString *urlString = @"http://ucarjava.bceapp.com/detail?method=id";
    [self getWithUrl:urlString param:param dictForResultClass:[YLDetailModel class] success:success failure:failure];
}

@end
