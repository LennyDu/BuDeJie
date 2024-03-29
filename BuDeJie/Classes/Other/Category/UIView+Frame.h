//
//  UIView+Frame.h
//  BuDeJie
//
//  Created by Lenny on 2017/2/1.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property CGFloat dl_width;
@property CGFloat dl_height;
@property CGFloat dl_x;
@property CGFloat dl_y;
@property CGFloat dl_centerX;
@property CGFloat dl_centerY;

/** 从xib加载view */
+ (instancetype)dl_viewFromXib;
@end
