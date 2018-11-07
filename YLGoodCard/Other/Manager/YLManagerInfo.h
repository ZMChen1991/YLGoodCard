//
//  YLManagerInfo.h
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLManagerInfo : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *tel;

- (instancetype)initWithDict:(NSDictionary *)Dict;

// 保存用户信息
+ (void)saveManagerInfo:(YLManagerInfo *)managerInfo;
// 返回用户信息
+ (YLManagerInfo *)returnManagerInfo;

@end
