//
//  DLEssenceViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/1/31.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLEssenceViewController.h"
#import "UIBarButtonItem+Item.h"
#import "DLTitleButton.h"

@interface DLEssenceViewController ()
/** 标题栏 */
@property (nonatomic,weak) UIView *titlesView;
/** 下划线 */
@property (nonatomic,weak) UIView *titleUnderline;
/** 上一次选中的按钮 */
@property (nonatomic,weak) DLTitleButton *previousClickedTitleButton;

@end

@implementation DLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavBar];
    
    [self setupScrollView];
    
    [self setupTitlesView];
}

/**
 初始化导航栏
 */
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

/**
 ScrollView
 */
- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
}

/**
 TitlesView
 */
- (void)setupTitlesView {
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.frame = CGRectMake(0, 64, self.view.dl_width, 35);
    [self.view addSubview:titlesView];
    _titlesView = titlesView;
    
    [self setupTitleButtons];
    
    [self setupTitleUnderline];
}

/**
 初始化标题按钮
 */
- (void)setupTitleButtons {
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    
    //标题按钮的尺寸
    CGFloat titleButtonW = self.titlesView.dl_width / count;
    CGFloat titleButtonH = self.titlesView.dl_height;
    
    for (NSUInteger i = 0; i < count; i++) {
        DLTitleButton *titleButton = [[DLTitleButton alloc] init];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
    }
}

/**
 标题下划线
 */
- (void)setupTitleUnderline {
    DLTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    //下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.dl_height = 2;
    titleUnderline.dl_y = self.titlesView.dl_height - titleUnderline.dl_height;
    
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    _titleUnderline = titleUnderline;
    
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit]; //根据文字内容计算label的尺寸
    titleUnderline.dl_width = firstTitleButton.titleLabel.dl_width + 10;
    titleUnderline.dl_centerX = firstTitleButton.dl_centerX;
}

#pragma mark - 监听

/**
 点击标题按钮

 @param titleButton 点击的标题按钮
 */
- (void)titleButtonClick:(DLTitleButton *)titleButton {
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.titleUnderline.dl_centerX = titleButton.dl_centerX;
        self.titleUnderline.dl_width = titleButton.titleLabel.dl_width + 10;
    }];
}

/**
 点击导航栏游戏图标
 */
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
