//
//  DLWordCell.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/21.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLWordCell.h"

@implementation DLWordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor yellowColor];
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
