//
//  DLTabBar.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/1.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLTabBar.h"
#import "DLPublishViewController.h"

@implementation DLTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    NSLog(@"%@", self.subviews);
    
    CGFloat btnX = 0;
    CGFloat btnW = self.dl_width / (self.items.count + 1);
    CGFloat btnH = self.dl_height;
    
    NSInteger i = 0;
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i++;
            }
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, btnH);
            i++;
        }
    }
    
    
    [self setupPlusButton];
}

#pragma mark - 设置中间的加号按钮
- (void)setupPlusButton {
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
    
    [plusButton sizeToFit];
    plusButton.center = CGPointMake(self.dl_width * 0.5, self.dl_height * 0.5);
    [self addSubview:plusButton];
}

@end
