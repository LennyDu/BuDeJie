//
//  DLTopicPictureView.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/23.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLTopicPictureView.h"
#import "DLTopicItem.h"

#import "DLSeeBigPictureViewController.h"

@interface DLTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@end

@implementation DLTopicPictureView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}

- (void)seeBigPicture {
    DLSeeBigPictureViewController *vc = [[DLSeeBigPictureViewController alloc] init];
    vc.topic = self.topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setTopic:(DLTopicItem *)topic {
    _topic = topic;
    
    //设置图片
    self.placeholderView.hidden = NO;
    [self.imageView dl_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        
        self.placeholderView.hidden = YES;
        
        //处理超长图片的大小
        if (topic.isBigPicture) {
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = imageW * topic.height / topic.width;
            
            //开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            //绘制图片到上下文中
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            //关闭上下文
            UIGraphicsEndImageContext();
        }

    }];
    
    //gif
    self.gifView.hidden = !topic.is_gif;
    
    //点击查看大图
    if (topic.isBigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

@end
