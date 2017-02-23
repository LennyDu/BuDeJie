//
//  UIImageView+Download.h
//  BuDeJie
//
//  Created by Lenny on 2017/2/23.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (Download)

- (void)dl_setOriginImage:(NSString *)originImageUrl thumbnailImage:(NSString *)thumbnailImageUrl placeholder:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock;

- (void)dl_setHeader:(NSString *)headerurl;
@end
