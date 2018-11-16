//
//  YLBrandCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/16.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBrandCell.h"

@implementation YLBrandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *icon = [[UIImageView alloc] init];
        [self addSubview:icon];
        
        UILabel *brand = [[UILabel alloc] init];
        [self addSubview:brand];
    }
    return self;
}

@end
