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

#import "DLAllViewController.h"
#import "DLVideoViewController.h"
#import "DLVoiceViewController.h"
#import "DLPictureViewController.h"
#import "DLWordViewController.h"

@interface DLEssenceViewController () <UIScrollViewDelegate>
/** ScrollView */
@property (nonatomic,weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic,weak) UIView *titlesView;
/** 下划线 */
@property (nonatomic,weak) UIView *titleUnderline;
/** 上一次选中的按钮 */
@property (nonatomic,weak) DLTitleButton *previousClickedTitleButton;

@end

@implementation DLEssenceViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化子控制器
    [self setupAllChildVC];
    
    [self setupNavBar];
    
    [self setupScrollView];
    
    [self setupTitlesView];
    
    //首先只添加第0个控制器的view到ScrollView上
    [self addChildVcViewIntoScrollView];
}

/**
 初始化子控制器
 */
- (void)setupAllChildVC {
    [self addChildViewController:[[DLAllViewController alloc] init]];
    [self addChildViewController:[[DLVideoViewController alloc] init]];
    [self addChildViewController:[[DLVoiceViewController alloc] init]];
    [self addChildViewController:[[DLPictureViewController alloc] init]];
    [self addChildViewController:[[DLWordViewController alloc] init]];
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
    //在scrollView上面添加TableView, Tableview的Y会自动向下移动, 不允许自动修改内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = self.view.bounds;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.dl_width;
//    CGFloat scrollViewH = scrollView.dl_height;
//    
//    for (NSUInteger i = 0; i < count; i++) {
//        UIView *childVcView = self.childViewControllers[i].view;
//        childVcView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
//        [scrollView addSubview:childVcView];
//    }
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
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
        titleButton.tag = i;
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
    
    if (self.previousClickedTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:DLTitleButtonDidRepeatClickNotification object:nil];
    }
    
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    NSUInteger index = titleButton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        self.titleUnderline.dl_centerX = titleButton.dl_centerX;
        self.titleUnderline.dl_width = titleButton.titleLabel.dl_width + 10;
        
        //点击标题按钮后切换到对应的控制器
        CGFloat offsetX = self.scrollView.dl_width * titleButton.tag;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        [self addChildVcViewIntoScrollView];
    }];
    
    //点击标题按钮的时候, 设置点击按钮对应的tableView.scrollsToTop = YES, 其他的都为NO
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        scrollView.scrollsToTop = (i == index);
    }
}

/**
 点击导航栏游戏图标
 */
- (void)gameClick {
    DLFunc;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / scrollView.dl_width;
    
    DLTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleButtonClick:titleButton];
}

#pragma mark - 其他
/**
 懒加载添加子控制器
 */
- (void)addChildVcViewIntoScrollView {
    
    CGFloat scrollViewW = self.scrollView.dl_width;
    CGFloat offsetX = self.scrollView.contentOffset.x;
    NSUInteger index = offsetX / scrollViewW;

    UIViewController *childVc = self.childViewControllers[index];
    //之前View已经添加到scrollView上面则不再加载
    if (childVc.isViewLoaded) return;
    
//    CGFloat scrollViewH = self.scrollView.dl_height;

    UIView *childVcView = childVc.view;
//    childVcView.frame = CGRectMake(self.scrollView.bounds.origin.x, self.scrollView.bounds.origin.y, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);

//    childVcView.frame = CGRectMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);

//    childVcView.frame = CGRectMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y, scrollViewW, self.scrollView.xmg_height);

//    childVcView.frame = CGRectMake(self.scrollView.contentOffset.x, 0, scrollViewW, self.scrollView.xmg_height);

//    childVcView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.scrollView.xmg_height);
    childVcView.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVcView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
