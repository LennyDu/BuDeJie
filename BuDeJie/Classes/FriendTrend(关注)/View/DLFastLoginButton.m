//
//  DLFastLoginButton.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/4.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLFastLoginButton.h"

@implementation DLFastLoginButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.dl_y = 0;
    self.imageView.dl_centerX = self.dl_width * 0.5;
    
    self.titleLabel.dl_y = self.dl_height - self.titleLabel.dl_height;
    
    // 计算文字宽度 , 设置label的宽度
    [self.titleLabel sizeToFit];
    
    self.titleLabel.dl_centerX = self.dl_width * 0.5;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
