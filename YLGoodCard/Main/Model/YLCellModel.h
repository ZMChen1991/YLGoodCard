//
//  YLCellModel.h
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLCellModel : NSObject

@property (nonatomic, strong) NSString *image; // 图片
@property (nonatomic, strong) NSString *name; // 名称
@property (nonatomic, strong) NSString *subtitle; // 子标题
@property (nonatomic, strong) NSString *Price; // 新车价格
@property (nonatomic, strong) NSString *secondPrice; // 二手价格

@end
