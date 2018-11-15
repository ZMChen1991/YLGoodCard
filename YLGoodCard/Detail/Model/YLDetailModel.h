//
//  YLDetailModel.h
//  YLGoodCard
//
//  Created by lm on 2018/11/14.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLDetailModel : NSObject

@property (nonatomic, strong) NSString *title;// 标题
@property (nonatomic, strong) NSString *brand;// 品牌
@property (nonatomic, strong) NSString *series;// 车系
@property (nonatomic, strong) NSString *price;// 价格
@property (nonatomic, strong) NSString *bodyStructure;// 车型
@property (nonatomic, assign) BOOL isLocal;// 是否本地
@property (nonatomic, strong) NSString *location;// 车牌所在地
@property (nonatomic, strong) NSString *gearbox;
@property (nonatomic, strong) NSString *vehileAge;
@property (nonatomic, strong) NSString *course;
@property (nonatomic, strong) NSString *emission;
@property (nonatomic, strong) NSString *emissionStandrd;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *seatsNum;
@property (nonatomic, strong) NSString *fuelForm;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *panoramicSunroof;
@property (nonatomic, strong) NSString *stabilityControl;
@property (nonatomic, strong) NSString *reverseVideo;
@property (nonatomic, strong) NSString *genuineLeather;
@property (nonatomic, strong) NSString *keylessEntrySystem;

@end

NS_ASSUME_NONNULL_END
