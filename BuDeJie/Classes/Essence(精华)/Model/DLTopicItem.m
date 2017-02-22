//
//  DLTopicItem.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/21.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLTopicItem.h"

@implementation DLTopicItem

- (CGFloat)cellHeight {
    if (_cellHeight) return _cellHeight;
    DLFunc;
    _cellHeight += 55;
    
    CGSize textMaxSize = CGSizeMake(DLScreenW - 2 * DLMargin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + DLMargin;
    
    _cellHeight += 35 + DLMargin;
    
    return _cellHeight;
}

@end
