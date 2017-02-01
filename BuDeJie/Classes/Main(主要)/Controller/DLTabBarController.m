//
//  DLTabBarController.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/1.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLTabBarController.h"
#import "DLEssenceViewController.h"
#import "DLNewViewController.h"
#import "DLFriendTrendViewController.h"
#import "DLMeTableViewController.h"
#import "DLNavigationController.h"

#import "DLTabBar.h"

@interface DLTabBarController ()

@end

@implementation DLTabBarController


//只会调用一次
+ (void)load {
//    NSMutableArray *appearanceContainerArray = [NSMutableArray array];
    
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupAllChildVc];
    
    [self setupAllTitleButton];
    
    [self setupTabBar];
}

- (void)setupTabBar {
    DLTabBar *tabBar = [[DLTabBar alloc] init];
//    self.tabBar = tabBar;
    
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)setupAllChildVc {
    //精华
    DLEssenceViewController *vc0 = [[DLEssenceViewController alloc] init];
    DLNavigationController *nav0 = [[DLNavigationController alloc] initWithRootViewController:vc0];
    [self addChildViewController:nav0];
    
    //新帖
    DLNewViewController *vc1 = [[DLNewViewController alloc] init];
    DLNavigationController *nav1 = [[DLNavigationController alloc] initWithRootViewController:vc1];
    [self addChildViewController:nav1];
    
    //关注
    DLFriendTrendViewController *vc2 = [[DLFriendTrendViewController alloc] init];
    DLNavigationController *nav2 = [[DLNavigationController alloc] initWithRootViewController:vc2];
    [self addChildViewController:nav2];
    
    //我的
    DLMeTableViewController *vc3 = [[DLMeTableViewController alloc] init];
    DLNavigationController *nav3 = [[DLNavigationController alloc] initWithRootViewController:vc3];
    [self addChildViewController:nav3];

}

- (void)setupAllTitleButton {
    UINavigationController *nav0 = self.childViewControllers[0];
    nav0.tabBarItem.title = @"精华";
    nav0.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_essence_icon"];
    nav0.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
//    UIViewController *vc3 = self.childViewControllers[2];
//    vc3.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_publish_icon"];
//    vc3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
    
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"关注";
    nav2.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_friendTrends_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
    UINavigationController *nav3= self.childViewControllers[3];
    nav3.tabBarItem.title = @"我的";
    nav3.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_me_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
