//
//  YLSalerInformation.h
//  YLGoodCard
//
//  Created by lm on 2018/11/19.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLSalerInformation : NSObject <NSCoding>

@property (nonatomic, strong) NSString *telephone;// 电话
@property (nonatomic, strong) NSString *city;// 城市
@property (nonatomic, strong) NSString *centerId;// 检测中心
@property (nonatomic, strong) NSString *brandId;// 品牌
@property (nonatomic, strong) NSString *seriesId;// 车系
@property (nonatomic, strong) NSString *typeId;// 车型
@property (nonatomic, strong) NSString *licenseTime; // 上牌时间
@property (nonatomic, strong) NSString *location;// 车牌所在地
@property (nonatomic, strong) NSString *course; // 里程
@property (nonatomic, strong) NSString *examineTime; // 验车时间

+ (void)saveInformation:(YLSalerInformation *)saler;

+ (YLSalerInformation *)takeInformation;

+ (instancetype)saler;

@end

NS_ASSUME_NONNULL_END
