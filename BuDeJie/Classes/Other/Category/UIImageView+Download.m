//
//  UIImageView+Download.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/23.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "UIImageView+Download.h"
#import <AFNetworking.h>

@implementation UIImageView (Download)
- (void)dl_setOriginImage:(NSString *)originImageUrl thumbnailImage:(NSString *)thumbnailImageUrl placeholder:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock {
    
    //根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    //获取原图
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageUrl];
    if (originImage) { //原图已经下载过
        self.image = originImage;
    } else { //原图未下载过
        if (mgr.isReachableViaWiFi) { //Wi-Fi网络
            [self sd_setImageWithURL:[NSURL URLWithString:originImageUrl] placeholderImage:placeholder completed:completedBlock];
        } else if (mgr.isReachableViaWWAN) { //蜂窝网络
            //是否下载原图这个配置项应该从沙盒中读取
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                [self sd_setImageWithURL:[NSURL URLWithString:originImageUrl] placeholderImage:placeholder completed:completedBlock];
            } else {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageUrl] placeholderImage:placeholder completed:completedBlock];
            }
        } else {//没有网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageUrl];
            if (thumbnailImage) {//下载过缩略图
                self.image = thumbnailImage;
            } else {//没下载过, 也没有网络, 只能用占位图片咯
                self.image = placeholder;
            }
        }
    }
}

- (void)dl_setHeader:(NSString *)headerurl {
    UIImage *placeholder = [UIImage dl_circleImageNamed:@"defaultUsericon"];
    [self sd_setImageWithURL:[NSURL URLWithString:headerurl] placeholderImage:placeholder options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        
        self.image = [image dl_circleImage];
    }];
}
@end
