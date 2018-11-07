//
//  YLOrderView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSaleButton.h"

@interface YLOrderView : UIView

@property (nonatomic, strong) YLSaleButton *saleBtn; // 预约卖车
@property (nonatomic, strong) YLSaleButton *consultBtn; // 免费咨询

@end
