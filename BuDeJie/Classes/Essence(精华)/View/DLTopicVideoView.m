//
//  DLTopicVideoView.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/23.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLTopicVideoView.h"
#import "DLTopicItem.h"

@interface DLTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@end

@implementation DLTopicVideoView

- (void)setTopic:(DLTopicItem *)topic {
    _topic = topic;
    
    [self.imageView dl_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        
        self.placeholderView.hidden = YES;
    }];
    
    
    //播放数量
    if (topic.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放", topic.playcount/10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    }
    
    //播放时长
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topic.videotime / 60, topic.videotime % 60];
}

@end
