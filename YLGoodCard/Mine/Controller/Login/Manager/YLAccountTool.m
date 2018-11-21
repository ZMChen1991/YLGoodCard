//
//  YLAccountTool.m
//  YLGoodCard
//
//  Created by lm on 2018/11/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

// 账号存储路径
#define YLAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"]

#import "YLAccountTool.h"

@implementation YLAccountTool

+ (void)saveAccount:(YLAccount *)account {
    NSLog(@"%@", YLAccountPath);
    [NSKeyedArchiver archiveRootObject:account toFile:YLAccountPath];
}

+ (YLAccount *)account {
    
    YLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:YLAccountPath];
    // 此处没有想好，以后再修改
//    // 如果登录时间超过1小时，
//    // 2018-11-21 10:14:30
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSDate *createAt = [dateFormatter dateFromString:account.createAt];
//    NSDate *now = [NSDate date];
//    NSLog(@"%@----%@", createAt, now);
//    NSComparisonResult result = [createAt compare:now];
//    if (result != NSOrderedDescending) {
//        return nil;
//    }
    return account;
}

@end
