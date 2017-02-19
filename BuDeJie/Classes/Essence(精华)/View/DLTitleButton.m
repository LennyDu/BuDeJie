//
//  DLTitleButton.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/19.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLTitleButton.h"

@implementation DLTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    //重写这个方法, 按钮就无法进入highlighted状态
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
