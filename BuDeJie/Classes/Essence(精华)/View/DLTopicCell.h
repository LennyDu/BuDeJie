//
//  DLTopicCell.h
//  BuDeJie
//
//  Created by Lenny on 2017/2/21.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLTopicItem;
@interface DLTopicCell : UITableViewCell
/** 传入模型数据 */
@property (nonatomic,strong) DLTopicItem *topic;
@end
