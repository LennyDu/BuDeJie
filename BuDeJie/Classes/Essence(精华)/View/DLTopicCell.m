//
//  DLTopicCell.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/21.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLTopicCell.h"
#import "DLTopicItem.h"

@implementation DLTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setTopic:(DLTopicItem *)topic {
    _topic = topic;
    
    UILabel *label = (UILabel *)[self viewWithTag:10];
    label.text = [NSString stringWithFormat:@"%@ - %zd", self.class, topic.type];
    [label sizeToFit];
}

@end
