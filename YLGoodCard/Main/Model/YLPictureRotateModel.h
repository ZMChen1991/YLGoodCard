//
//  YLPictureRotateModel.h
//  YLGoodCard
//
//  Created by lm on 2018/11/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLPictureRotateModel : NSObject

@property (nonatomic, strong) NSString *creatAt;
@property (nonatomic, strong) NSString *ID;// 这里id需要转换
@property (nonatomic, strong) NSString *img; // 图片
@property (nonatomic, strong) NSString *updateAt;// 更新时间
@property (nonatomic, strong) NSString *url; // 网页链接

@end

NS_ASSUME_NONNULL_END
