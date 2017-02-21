//
//  DLVideoCell.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/21.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLVideoCell.h"

@implementation DLVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setTopic:(DLTopicItem *)topic {
    [super setTopic:topic];
    
    
}

@end
