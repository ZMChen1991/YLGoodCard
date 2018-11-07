//
//  YLCarInformationCell.h
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLCarInformationCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;// 照片
@property (nonatomic, strong) UILabel *detail;// 详情
@property (nonatomic, assign) float height;// cell高
@end
