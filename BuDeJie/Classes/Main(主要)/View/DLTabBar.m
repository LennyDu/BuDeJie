//
//  DLTabBar.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/1.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLTabBar.h"
#import "DLPublishViewController.h"

@interface DLTabBar ()
/** 上一次点击的按钮 */
@property (nonatomic,weak) UIControl *previousClickedTabBarButton;
@end

@implementation DLTabBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    NSLog(@"%@", self.subviews);
    
    CGFloat btnX = 0;
    CGFloat btnW = self.dl_width / (self.items.count + 1);
    CGFloat btnH = self.dl_height;
    
    NSInteger i = 0;
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i++;
            }
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, btnH);
            i++;
            
            //监听点击
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    [self setupPlusButton];
}

/**
 点击tabBarButton

 @param tabBarButton 点击的tabBarButton
 */
- (void)tabBarButtonClick:(UIControl *)tabBarButton {
    if (self.previousClickedTabBarButton == tabBarButton) {
        //此次点击的按钮和上一次点击的是同一个按钮, 即双击了一个按钮, 发出双击通知
        [[NSNotificationCenter defaultCenter] postNotificationName:DLTabBarButtonDidRepeatClickNotification object:nil];
    }
    
    self.previousClickedTabBarButton = tabBarButton;
}

/** 设置中间的加号按钮 */
- (void)setupPlusButton {
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
    
    [plusButton sizeToFit];
    plusButton.center = CGPointMake(self.dl_width * 0.5, self.dl_height * 0.5);
    [self addSubview:plusButton];
}

@end
