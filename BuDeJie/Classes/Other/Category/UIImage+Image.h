//
//  UIImage+Image.h
//  BuDeJie
//
//  Created by Lenny on 2017/2/1.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
+ (UIImage *)imageOriginalWithName:(NSString *)imageName;
- (instancetype)dl_circleImage;
+ (instancetype)dl_circleImageNamed:(NSString *)name;
@end
