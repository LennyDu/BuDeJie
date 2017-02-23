//
//  DLTopicVoiceView.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/23.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLTopicVoiceView.h"
#import "DLTopicItem.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface DLTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@end

@implementation DLTopicVoiceView

- (void)setTopic:(DLTopicItem *)topic {
    _topic = topic;
    
    [self.imageView dl_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        
        self.placeholderView.hidden = YES;
    }];
    
//    //占位图片
//    UIImage *placeholder = nil;
//    //根据网络状态来加载图片
//    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
//    //获取原图
//    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image1];
//    if (originImage) { //原图已经下载过
//        self.imageView.image = originImage;
//    } else { //原图未下载过
//        if (mgr.isReachableViaWiFi) { //Wi-Fi网络
//            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
//        } else if (mgr.isReachableViaWWAN) { //蜂窝网络
//            //是否下载原图这个配置项应该从沙盒中读取
//            BOOL downloadOriginImageWhen3GOr4G = YES;
//            if (downloadOriginImageWhen3GOr4G) {
//                [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
//            } else {
//                [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:placeholder];
//            }
//        } else {//没有网络
//            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image0];
//            if (thumbnailImage) {//下载过缩略图
//                self.imageView.image = thumbnailImage;
//            } else {//没下载过, 也没有网络, 只能用占位图片咯
//                self.imageView.image = placeholder;
//            }
//        }
//    }
    
    //播放数量
    if (topic.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放", topic.playcount/10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    
    //播放时长
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.voicetime / 60, topic.voicetime % 60];
}

@end
