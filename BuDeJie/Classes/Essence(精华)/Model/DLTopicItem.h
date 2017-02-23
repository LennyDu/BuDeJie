//
//  DLTopicItem.h
//  BuDeJie
//
//  Created by Lenny on 2017/2/21.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DLTopicTypeAll = 1,
    DLTopicTypePicture = 10,
    DLTopicTypeWord = 29,
    DLTopicTypeVoice = 31,
    DLTopicTypeVideo = 41
} DLTopicType;

@interface DLTopicItem : NSObject
/** 用户的名字 */
@property (nonatomic,copy) NSString *name;
/** 用户的头像 */
@property (nonatomic,copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic,copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic,copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic,assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic,assign) NSInteger cai;
/** 转发/分享数量 */
@property (nonatomic,assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic,assign) NSInteger comment;

/** 帖子类型 1为全部，10为图片，29为段子，31为音频，41为视频 */
@property (nonatomic,assign) NSInteger type;

/** 中间控件的像素宽度 */
@property (nonatomic,assign) NSInteger width;
/** 中间控件的像素高度 */
@property (nonatomic,assign) NSInteger height;

/** 最热评论 */
@property (nonatomic,strong) NSArray *top_cmt;

/** 小图 */
@property (nonatomic,copy) NSString *image0;
/** 大图 */
@property (nonatomic,copy) NSString *image1;
/** 中图 */
@property (nonatomic,copy) NSString *image2;
/** 是否为动图 */
@property (nonatomic,assign) BOOL is_gif;

/** 音频时长 */
@property (nonatomic,assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic,assign) NSInteger videotime;
/** 音频/视频播放次数 */
@property (nonatomic,assign) NSInteger playcount;

/** 为了避免每次都计算cell的高度, 新增一个高度属性 */
@property (nonatomic,assign) CGFloat cellHeight;

/** 中间控件的frame */
@property (nonatomic,assign) CGRect middleFrame;

/** 是否为超长图片 */
@property (nonatomic,assign, getter=isBigPicture) BOOL bigPicture;
@end
