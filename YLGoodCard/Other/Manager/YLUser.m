//
//  YLUser.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLUser.h"

@implementation YLUser

- (instancetype)initWithDict:(NSDictionary *)Dict {
    
    YLUser *manager = [[YLUser alloc] init];
    return manager;
}

+ (void)saveManagerInfo:(YLUser *)managerInfo {
    
    [NSKeyedArchiver archiveRootObject:managerInfo toFile:YLUserPath];
}

+ (YLUser *)returnManagerInfo {
    
    YLUser *managerInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:YLUserPath];
    return managerInfo;
}

@end
