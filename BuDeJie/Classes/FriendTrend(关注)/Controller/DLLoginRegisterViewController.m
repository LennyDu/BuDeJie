//
//  DLLoginRegisterViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/4.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLLoginRegisterViewController.h"
#import "DLLoginRegisterView.h"
#import "DLFastLoginView.h"

@interface DLLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewLeadingCons;
@end

@implementation DLLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    DLLoginRegisterView *loginView = [DLLoginRegisterView loginView];
    [self.middleView addSubview:loginView];
    
    DLLoginRegisterView *registerView = [DLLoginRegisterView registerView];
    [self.middleView addSubview:registerView];
    
    DLFastLoginView *fastLoginView = [DLFastLoginView fastLoginView];
    [self.bottomView addSubview:fastLoginView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    DLLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.dl_width * 0.5, self.middleView.dl_height);
    
    DLLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.dl_width * 0.5, 0, self.middleView.dl_width * 0.5, self.middleView.dl_height);
    
    DLFastLoginView *fastLoginView = [self.bottomView.subviews lastObject];
    fastLoginView.frame = CGRectMake(0, 0, self.bottomView.dl_width, self.bottomView.dl_height);
}

#pragma mark 点击关闭按钮
- (IBAction)clickCloseButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 点击注册按钮
- (IBAction)clickRegisterButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    
    //通过改变约束条件来实现登录和注册view的切换
    _middleViewLeadingCons.constant = (_middleViewLeadingCons.constant == 0)?(-_middleView.dl_width*0.5):(0);
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
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
