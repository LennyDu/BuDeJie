//
//  UIImage+Image.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/1.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (UIImage *)imageOriginalWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (instancetype)dl_circleImage {
    //1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.描述裁剪区域
    //bezierPathWithOvalInRect: 传入一个矩形, 形成一个内切椭圆路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //3.设置裁剪区域
    [path addClip];
    //4.画图
    [self drawAtPoint:CGPointZero];
    //5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)dl_circleImageNamed:(NSString *)name {
    return [[self imageNamed:name] dl_circleImage];
}

@end
