//
//  NSString+Extension.h
//  YLGoodCard
//
//  Created by lm on 2018/11/8.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (CGSize)getSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

- (CGSize)getSizeWithFont:(UIFont *)font;
@end
