//
//  DLFriendTrendViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/1/31.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLFriendTrendViewController.h"
#import "UIBarButtonItem+Item.h"
#import "DLLoginRegisterViewController.h"

@interface DLFriendTrendViewController ()

@end

@implementation DLFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavBar];
}

#pragma mark 点击登录注册按钮
- (IBAction)clickLoginRegisterBtn:(UIButton *)sender {
    DLLoginRegisterViewController *loginRegisterVc = [[DLLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegisterVc animated:YES completion:nil];
}
#pragma mark - 设置导航条
- (void)setupNavBar
{
    // 左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    
    // titleView
    self.navigationItem.title = @"我的关注";
    
}

// 推荐关注
- (void)friendsRecomment
{
    
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
