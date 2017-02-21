//
//  DLVoiceCell.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/21.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLVoiceCell.h"

@implementation DLVoiceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor greenColor];
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
