//
//  YLChangePriceView.h
//  YLGoodCard
//
//  Created by lm on 2018/12/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ChangePriceBlock)(NSString *price, NSString *floor, BOOL isAccept);
@interface YLChangePriceView : UIView

@property (nonatomic, copy) ChangePriceBlock changePriceBlock;

@end

NS_ASSUME_NONNULL_END
