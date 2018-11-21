//
//  YLBaseTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBaseTool.h"
#import "YLRequest.h"
#import "MJExtension.h"

@implementation YLBaseTool

// 字典转模型
+ (void)getWithUrl:(NSString *)url param:(id)param dictForResultClass:(Class)resultClass success:(void (^)(id result))success failure:(void (^)(NSError *error))failure {
    
    NSDictionary *params = [param mj_keyValues];
    [YLRequest GET:url parameters:params responseCache:nil success:^(id responseObject) {
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObject[@"data"]];
//            NSLog(@"result:%@",result);
            success(result);// 返回的是存放模型类的数组
        }
    } failed:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 模型数组
+ (void)getWithUrl:(NSString *)url param:(id)param arrayForResultClass:(Class)resultClass success:(void (^)(id result))success failure:(void (^)(NSError *error))failure {
    
    NSDictionary *params = [param mj_keyValues];
    [YLRequest GET:url parameters:params responseCache:nil success:^(id responseObject) {
        if (success) {
            id result = [resultClass mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//            NSLog(@"result:%@",result);
            success(result);// 返回的是存放模型类的数组
        }
    } failed:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    NSDictionary *params = [param mj_keyValues];
    [YLRequest POST:url parameters:params responseCache:nil success:^(id  _Nonnull responseObject) {
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObject[@"data"]];
            success(result);
        }
    } failed:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
