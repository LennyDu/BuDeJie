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
    
    //文字的Y
    _cellHeight += 55;
    
    //文字的高度
    CGSize textMaxSize = CGSizeMake(DLScreenW - 2 * DLMargin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + DLMargin;
    
    //最热评论
    if (self.top_cmt.count) {
        //最热评论标题高度
        _cellHeight += 21;
        //最热评论内容高度
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        NSString *cmtText = [NSString stringWithFormat:@"%@ : %@", username, content];
        _cellHeight += [cmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height + DLMargin;
    }
    
    //工具条
    _cellHeight += 35 + DLMargin;
    
    return _cellHeight;
}

@end
