//
//  YLHomeHeader.m
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLHomeHeader.h"
#import "YLBanner.h"
#import "YLNotable.h"
#import "YLTableGroupHeader.h"


@implementation YLHomeHeader

- (instancetype)initWithFrame:(CGRect)frame bannerTitles:(NSMutableArray *)bannerTitles notabletitles:(NSMutableArray *)notabletitles {
    
    self = [super initWithFrame:(frame)];
    if (self) {
        float width = frame.size.width;
        CGRect bannerRect = CGRectMake(0, 0, width, 220);
        YLBanner *banner = [[YLBanner alloc] initWithFrame:bannerRect Images:bannerTitles isRunning:YES];
//        banner.images = bannerTitles;
//        banner.backgroundColor = YLRandomColor;
        [self addSubview:banner];
        
        CGRect notableRect = CGRectMake(0, CGRectGetMaxY(banner.frame), width, 60);
        YLNotable *notable = [[YLNotable alloc] initWithWithFrame:notableRect titles:notabletitles];
//        notable.backgroundColor = YLRandomColor;
        [self addSubview:notable];
        
        CGRect goupHeaderRect = CGRectMake(0, CGRectGetMaxY(notable.frame), width, 44);
        YLTableGroupHeader *groupHeader = [[YLTableGroupHeader alloc] initWithFrame:goupHeaderRect image:@"热门二手车" title:@"热门二手车" detailTitle:@"查看更多" arrowImage:@"更多"];
//        groupHeader.backgroundColor = YLRandomColor;
        [self addSubview:groupHeader];
        
        NSArray *btnTitles = [NSArray arrayWithObjects:@"5万以下", @"5-10万", @"10-15万", @"15万以上", @"哈弗", @"丰田",@"大众", @"本田", @"力帆", @"日产", @"雪佛兰", @"更多", nil];
        CGRect buttonRect = CGRectMake(0, CGRectGetMaxY(groupHeader.frame), width, 99);
        YLButtonView *buttonView = [[YLButtonView alloc] initWithFrame:buttonRect btnTitles:btnTitles];
//        buttonView.backgroundColor = YLRandomColor;
        [self addSubview:buttonView];
        self.buttonView = buttonView;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(buttonView.frame), width, 1)];
        line.backgroundColor = YLColor(233.f, 233.f, 233.f);
        [self addSubview:line];
    }
    return self;
}
@end
