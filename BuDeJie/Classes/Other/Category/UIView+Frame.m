//
//  UIView+Frame.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/1.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setDl_width:(CGFloat)dl_width {
    CGRect rect = self.frame;
    rect.size.width = dl_width;
    self.frame = rect;
}

- (CGFloat)dl_width {
    return self.frame.size.width;
}

- (void)setDl_height:(CGFloat)dl_height {
    CGRect rect = self.frame;
    rect.size.height = dl_height;
    self.frame = rect;
}

- (CGFloat)dl_height {
    return self.frame.size.height;
}

- (void)setDl_x:(CGFloat)dl_x {
    CGRect rect = self.frame;
    rect.origin.x = dl_x;
    self.frame = rect;
}

- (CGFloat)dl_x {
    return self.frame.origin.x;
}

- (void)setDl_y:(CGFloat)dl_y {
    CGRect rect = self.frame;
    rect.origin.y = dl_y;
    self.frame = rect;
}

- (CGFloat)dl_y {
    return self.frame.origin.y;
}
@end
