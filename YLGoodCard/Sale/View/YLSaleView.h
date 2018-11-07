//
//  YLSaleView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSaleViewModel.h"
#import "YLSaleButton.h"

@interface YLSaleView : UIView

@property (nonatomic, strong) YLSaleViewModel *model;
@property (nonatomic, strong) YLSaleButton *saleBtn; // 预约卖车
@property (nonatomic, strong) YLSaleButton *consultBtn; // 免费咨询
@property (nonatomic, strong) YLSaleButton *appraiseBtn;// 爱车估价

@end
