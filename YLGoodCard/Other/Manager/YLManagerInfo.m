//
//  YLManagerInfo.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLManagerInfo.h"

@implementation YLManagerInfo

- (instancetype)initWithDict:(NSDictionary *)Dict {
    
    YLManagerInfo *manager = [[YLManagerInfo alloc] init];
    return manager;
}

+ (void)saveManagerInfo:(YLManagerInfo *)managerInfo {
    
    [NSKeyedArchiver archiveRootObject:managerInfo toFile:YLManagerInfoPath];
}

+ (YLManagerInfo *)returnManagerInfo {
    
    YLManagerInfo *managerInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:YLManagerInfoPath];
    return managerInfo;
}

@end
