//
//  DLTopicCell.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/21.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLTopicCell.h"
#import "DLTopicItem.h"

#import "DLTopicVideoView.h"
#import "DLTopicVoiceView.h"
#import "DLTopicPictureView.h"

#import <UIImageView+WebCache.h>

@interface DLTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;

/** 视频控件 */
@property (nonatomic,weak) DLTopicVideoView *videoView;
/** 声音控件 */
@property (nonatomic,weak) DLTopicVoiceView *voiceView;
/** 图片控件 */
@property (nonatomic,weak) DLTopicPictureView *pictureView;
@end

@implementation DLTopicCell
#pragma mark 懒加载中间控件
- (DLTopicVideoView *)videoView {
    if (!_videoView) {
        _videoView = [DLTopicVideoView dl_viewFromXib];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}

- (DLTopicVoiceView *)voiceView {
    if (!_voiceView) {
        _voiceView = [DLTopicVoiceView dl_viewFromXib];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

- (DLTopicPictureView *)pictureView {
    if (!_pictureView) {
        _pictureView = [DLTopicPictureView dl_viewFromXib];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}
/*
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
*/
- (void)setTopic:(DLTopicItem *)topic {
    _topic = topic;
    
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage dl_circleImageNamed:@"defaultUserIcon"] options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if (!image) return;
//        self.profileImageView.image = [image dl_circleImage];
//    }];
    [self.profileImageView dl_setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.passtimeLabel.text = topic.passtime;
    self.text_label.text = topic.text;
    
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    if (topic.top_cmt.count) {
        self.topCmtView.hidden = NO;
        
        NSDictionary *cmt = topic.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    } else {
        self.topCmtView.hidden = YES;
    }
    
    //中间控件
    if (topic.type == DLTopicTypeVideo) {
        _videoView.hidden = NO;
        self.videoView.topic = topic;
        _voiceView.hidden = YES;
        _pictureView.hidden = YES;
    } else if (topic.type == DLTopicTypeVoice) {
        _videoView.hidden = YES;
        _voiceView.hidden = NO;
        self.voiceView.topic = topic;
        _pictureView.hidden = YES;
    } else if (topic.type == DLTopicTypePicture) {
        _videoView.hidden = YES;
        _voiceView.hidden = YES;
        _pictureView.hidden = NO;
        self.pictureView.topic = topic;
    } else if (topic.type == DLTopicTypeWord) {
        _videoView.hidden = YES;
        _voiceView.hidden = YES;
        _pictureView.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.topic.type == DLTopicTypeVideo) {
        self.videoView.frame = self.topic.middleFrame;
    } else if (self.topic.type == DLTopicTypeVoice) {
        self.voiceView.frame = self.topic.middleFrame;
    } else if (self.topic.type == DLTopicTypePicture) {
        self.pictureView.frame = self.topic.middleFrame;
    }
}

- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder {
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= DLMargin;
    [super setFrame:frame];
}

@end
