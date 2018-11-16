//
//  YLMainController.h
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^myBlock)(NSString *title);
@interface YLMainController : UIViewController

@property (nonatomic, copy) myBlock block;

@end
