//
//  DLSubTagItem.h
//  BuDeJie
//
//  Created by Lenny on 2017/2/3.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLSubTagItem : NSObject
/** 头像地址 */
@property (nonatomic,strong) NSString *image_list;
/** 标签名 */
@property (nonatomic,strong) NSString *theme_name;
/** 订阅数 */
@property (nonatomic,strong) NSString *sub_number;
@end
