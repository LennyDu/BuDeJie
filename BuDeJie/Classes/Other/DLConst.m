//
//  DLConst.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/20.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import <UIKit/UIKit.h>

/** UITabBar的高度 */
CGFloat const DLTabBarH = 49;

/** 导航栏的最大Y值 */
CGFloat const DLNavMaxY = 64;

/** 标题栏的高度 */
CGFloat const DLTitlesViewH = 35;

/** 全局统一的间距 */
CGFloat const DLMargin = 10;

/** 同一的请求路径 */
NSString * const DLCommonURL = @"http://api.budejie.com/api/api_open.php";

/** TabBarButton被重复点击的通知 */
NSString * const DLTabBarButtonDidRepeatClickNotification = @"DLTabBarButtonDidRepeatClickNotification";

/** TitleButton被重复点击的通知 */
NSString * const DLTitleButtonDidRepeatClickNotification = @"DLTitleButtonDidRepeatClickNotification";
