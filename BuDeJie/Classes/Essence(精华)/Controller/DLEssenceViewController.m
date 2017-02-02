//
//  DLEssenceViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/1/31.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLEssenceViewController.h"
#import "UIBarButtonItem+Item.h"

@interface DLEssenceViewController ()

@end

@implementation DLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavBar];
}

#pragma mark - 初始化导航栏
- (void)setupNavBar {
    //自带的设置左边按钮的方法按钮的右边超过按钮区域也可以点击,不是我们要的效果
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageOriginalWithName:@"nav_item_game_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //左边游戏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(gameClick)];
    
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    
    //title
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)gameClick {
    DLFunc;
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
