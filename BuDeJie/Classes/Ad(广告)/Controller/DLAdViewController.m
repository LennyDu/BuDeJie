//
//  DLAdViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/2.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLAdViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "DLAdItem.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "DLTabBarController.h"

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface DLAdViewController ()
@property (nonatomic, strong) DLAdItem *item;
@property (nonatomic, weak) UIView *adContainView;
@property (nonatomic, weak) UIImageView *adImageView;
@property (nonatomic, weak) UIButton *skipButton;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation DLAdViewController

- (UIImageView *)adImageView {
    if (_adImageView == nil) {
        UIImageView *adImageView = [[UIImageView alloc] init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [adImageView addGestureRecognizer:tap];
        
        [self.adContainView addSubview:adImageView];
        adImageView.userInteractionEnabled = YES;
        
        _adImageView = adImageView;
    }
    
    return _adImageView;
}

- (void)tap {
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    UIApplication *application = [UIApplication sharedApplication];
    if ([application canOpenURL:url]) {
        NSDictionary *dict = [NSDictionary dictionary];
        [application openURL:url options:dict completionHandler:nil];
    }
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupLaunchImage];
    
    [self setupAdContainView];
    
    [self setupSkipButton];
    
    [self loadAdData];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

- (void)timeChange {
    static int i = 3;
    
    if (i == 0) {
        [self clickSkipBtn];
    }
    
    [_skipButton setTitle:[NSString stringWithFormat:@"跳过(%d)",i] forState:UIControlStateNormal];
    i--;
}

- (void)loadAdData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *url = @"http://mobads.baidu.com/cpro/ui/mads.php";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        _item = [DLAdItem mj_objectWithKeyValues:adDict];
        
        CGFloat adH = (DLScreenW / _item.w) * _item.h;
        self.adImageView.frame = CGRectMake(0, 0, DLScreenW, adH);
        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        
//        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark - 初始化跳过按钮
- (void)setupSkipButton {
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton setTitle:@"跳过(3)" forState:UIControlStateNormal];
    CGFloat space = 20;
    CGFloat btnW = 65;
    CGFloat btnH = 30;
    CGFloat btnX = self.view.dl_width - space - btnW;
    CGFloat btnY = space;
    skipButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    [skipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    skipButton.backgroundColor = [UIColor lightGrayColor];
    
    [skipButton addTarget:self action:@selector(clickSkipBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:skipButton];
    _skipButton = skipButton;
}

#pragma mark - 点击跳过按钮
- (void)clickSkipBtn {
    DLTabBarController *tabBarController = [[DLTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;
    
    [_timer invalidate];
}

- (void)setupAdContainView {
    UIView *adContainView = [[UIView alloc] initWithFrame:self.view.bounds];
    adContainView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:adContainView];
    _adContainView = adContainView;
}

- (void)setupLaunchImage {
    UIImageView *launchImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    if (iphone6P) {
        launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iphone6) {
        launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (iphone5) {
        launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
    } else if (iphone4) {
        launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }

    [self.view addSubview:launchImageView];
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
