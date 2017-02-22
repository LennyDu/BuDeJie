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

/** 为了避免每次都计算cell的高度, 新增一个高度属性 */
@property (nonatomic,assign) CGFloat cellHeight;
@end
