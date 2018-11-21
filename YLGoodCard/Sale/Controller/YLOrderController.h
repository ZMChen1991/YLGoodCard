//
//  YLOrderController.h
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLOrderView.h"

@interface YLOrderController : UIViewController

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSString *telephone;// 电话
@property (nonatomic, strong) YLOrderView *orderView;

@end
