//
//  YLAccount.m
//  YLGoodCard
//
//  Created by lm on 2018/11/21.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLAccount.h"

@implementation YLAccount

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    
    YLAccount *account = [[self alloc] init];
    account.telephone = dict[@"telephone"];
    account.status = dict[@"status"];
    account.ID = dict[@"ID"];
    account.token = dict[@"token"];
    account.createAt = [NSString stringByDate:[NSDate date]];
    return account;
}

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.telephone forKey:@"telephone"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.createAt forKey:@"createAt"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.telephone = [aDecoder decodeObjectForKey:@"telephone"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.createAt = [aDecoder decodeObjectForKey:@"createAt"];
    }
    return self;
}


@end
