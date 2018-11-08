//
//  NSString+Extension.m
//  YLGoodCard
//
//  Created by lm on 2018/11/8.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)getSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)getSizeWithFont:(UIFont *)font {
    
    return [self getSizeWithFont:font maxWidth:MAXFLOAT];
}

@end
