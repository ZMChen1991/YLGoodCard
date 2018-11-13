//
//  YLPictureRotateModel.m
//  YLGoodCard
//
//  Created by lm on 2018/11/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLPictureRotateModel.h"

@implementation YLPictureRotateModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
