//
//  DLAdItem.h
//  BuDeJie
//
//  Created by Lenny on 2017/2/2.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLAdItem : NSObject
/**广告的图片地址*/
@property (nonatomic, strong) NSString *w_picurl;
/**点击广告跳转的地址*/
@property (nonatomic, strong) NSString *ori_curl;

@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@end
