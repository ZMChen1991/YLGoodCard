//
//  YLSalerInformation.m
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSalerInformation.h"

@implementation YLSalerInformation

+ (instancetype)saler {
    
    return [[self alloc] init];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_telephone forKey:@"telephone"];
    [aCoder encodeObject:_city forKey:@"city"];
    [aCoder encodeObject:_centerId forKey:@"centerId"];
    [aCoder encodeObject:_brandId forKey:@"brandId"];
    [aCoder encodeObject:_seriesId forKey:@"seriesId"];
    [aCoder encodeObject:_typeId forKey:@"typeId"];
    [aCoder encodeObject:_licenseTime forKey:@"licenseTime"];
    [aCoder encodeObject:_location forKey:@"location"];
    [aCoder encodeObject:_course forKey:@"course"];
    [aCoder encodeObject:_examineTime forKey:@"examineTime"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        self.telephone = [aDecoder decodeObjectForKey:@"telephone"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.centerId = [aDecoder decodeObjectForKey:@"centerId"];
        self.brandId = [aDecoder decodeObjectForKey:@"brandId"];
        self.seriesId = [aDecoder decodeObjectForKey:@"seriesId"];
        self.typeId = [aDecoder decodeObjectForKey:@"typeId"];
        self.licenseTime = [aDecoder decodeObjectForKey:@"licenseTime"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.course = [aDecoder decodeObjectForKey:@"course"];
        self.examineTime = [aDecoder decodeObjectForKey:@"examineTime"];
    }
    return self;
}

+ (void)saveInformation:(YLSalerInformation *)saler {
    NSLog(@"%@", YLOrderAndAppraisePath);
    [NSKeyedArchiver archiveRootObject:saler toFile:YLOrderAndAppraisePath];
}

+ (YLSalerInformation *)takeInformation {
    
    YLSalerInformation * saler = [NSKeyedUnarchiver unarchiveObjectWithFile:YLOrderAndAppraisePath];
    return saler;
}
@end
