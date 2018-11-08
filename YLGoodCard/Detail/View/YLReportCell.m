//
//  YLReportCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLReportCell.h"

@implementation YLReportCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    
    static NSString *ID = @"cellID";
    YLReportCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLReportCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


@end
