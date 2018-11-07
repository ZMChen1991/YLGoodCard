//
//  YLTableHeaderView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLTableHeaderModel.h"
#import "YLButton.h"

//@class YLTableHeaderView;
//@protocol YLTableHeaderViewDelegate <NSObject>
//
//- (void)checkMore;
//
//@end

typedef NS_ENUM(NSInteger, YLTableHeaderType) {
    YLTableHeaderTypeNone,              // 无
    YLTableHeaderTypeTitle,             // 标题
    YLTableHeaderTypeSubtitle,          // 有子标题
    YLTableHeaderTypeImage,             // 有图标
};



@interface YLTableHeaderView : UIView

@property (nonatomic, assign) YLTableHeaderType tableHeadertype;
@property (nonatomic, strong) YLTableHeaderModel *tableHeaderModel;
@property (nonatomic, strong) YLButton *subTitle;


@end
