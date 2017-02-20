//
//  DLAllTableViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/20.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLAllTableViewController.h"

@interface DLAllTableViewController ()
/** 数据量 */
@property (nonatomic,assign) NSInteger dataCount;

/** 下拉刷新控件 */
@property (nonatomic,weak) UIView *header;

/** 下拉刷新控件里面的文字 */
@property (nonatomic,weak) UILabel *headerLabel;

/** 下拉刷新时候正在刷新 */
@property (nonatomic,assign, getter=isHeaderRefreshing) BOOL headerRefreshing;

/** 上拉刷新控件 */
@property (nonatomic,weak) UIView *footer;

/** 上拉刷新控件里面的文字 */
@property (nonatomic,weak) UILabel *footerLabel;

/** 上拉刷新时候正在刷新 */
@property (nonatomic,assign, getter=isFooterRefreshing) BOOL footerRefreshing;

@end

@implementation DLAllTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataCount = 5;
    
    self.view.backgroundColor = DLRandomColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(DLNavMaxY + DLTitlesViewH, 0, DLTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:DLTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:DLTitleButtonDidRepeatClickNotification object:nil];
    
    [self setupRefresh];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupRefresh {
    //广告条
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor blackColor];
    label.frame = CGRectMake(0, 0, 0, 30);
    label.textColor = [UIColor whiteColor];
    label.text = @"广告";
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = label;
    
    //header
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, -50, self.tableView.dl_width, 50);
    self.header = header;
    [self.tableView addSubview:header];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.frame = header.bounds;
    headerLabel.backgroundColor = [UIColor redColor];
    headerLabel.text = @"下拉可以刷新";
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:headerLabel];
    self.headerLabel = headerLabel;
    
    //首先让header
    [self headerBeginRefreshing];
    
    //footer
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, self.tableView.dl_width, 35);
    _footer = footer;
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.frame = footer.bounds;
    footerLabel.backgroundColor = [UIColor redColor];
    footerLabel.text = @"上拉可以加载更多";
    footerLabel.textColor = [UIColor whiteColor];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:footerLabel];
    _footerLabel = footerLabel;
    
    self.tableView.tableFooterView = footer;
}

#pragma mark - 监听
- (void)tabBarButtonDidRepeatClick {
    //此时点击的不是精华按钮
    if (self.view.window == nil) return;
    //此时点击的是精华按钮, 但是显示的不是"全部"控制器
    if (self.tableView.scrollsToTop == NO) return;
    
    NSLog(@"%@ - 刷新数据", self.class);
}

- (void)titleButtonDidRepeatClick {
    [self tabBarButtonDidRepeatClick];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.footer.hidden = (self.dataCount == 0);
    return self.dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd", self.class, indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //如果正在进行下拉刷新, 直接返回
//    if (self.headerRefreshing) return;
    
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.dl_height);
    if (self.tableView.contentOffset.y <= offsetY) {
        [self headerBeginRefreshing];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self dealHeader];
    
    [self dealFooter];
}

- (void)dealHeader {
    if (self.isHeaderRefreshing) return;
    
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.dl_height);
    
    if (self.tableView.contentOffset.y <= offsetY) {
        self.headerLabel.text = @"松开立即刷新";
        self.headerLabel.backgroundColor = [UIColor grayColor];
    } else {
        self.headerLabel.text = @"下拉可以刷新";
        self.headerLabel.backgroundColor = [UIColor redColor];
    }
}

- (void)dealFooter {
    //还没有任何内容的时候, 不需要判断
    if (self.tableView.contentSize.height == 0) return;
    
    //正在刷新, 直接返回
//    if (self.isFooterRefreshing) return;
    
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.dl_height;
    
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > - (self.tableView.contentInset.top)) {
        //进入刷新状态
        [self footerBeginRefreshing];
    }
}

#pragma mark - 数据处理
- (void)loadNewData {
    NSLog(@"发送请求给服务器, 下拉刷新数据");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //服务器返回数据
        self.dataCount = 20;
        [self.tableView reloadData];
        
        //结束刷新
        [self headerEndRefreshing];
    });
}

- (void)loadMoreData {
    NSLog(@"发送请求给服务器 - 加载更多数据");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //服务器返回数据
        self.dataCount += 5;
        [self.tableView reloadData];
        
        //结束刷新
        [self footerEndRefreshing];
    });
}

#pragma mark - header
- (void)headerBeginRefreshing {
    if (self.isHeaderRefreshing) return;
    
    //进入下拉刷新状态
    self.headerLabel.text = @"正在刷新数据...";
    self.headerLabel.backgroundColor = [UIColor blueColor];
    self.headerRefreshing = YES;
    
    //增加内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.header.dl_height;
        self.tableView.contentInset = inset;
        
        //修改偏移量
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -inset.top);
    }];
    
    [self loadNewData];
}

- (void)headerEndRefreshing {
    //结束刷新
    self.headerRefreshing = NO;
    //还原内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.header.dl_height;
        self.tableView.contentInset = inset;
    }];

}

#pragma mark - footer
- (void)footerBeginRefreshing {
    if (self.isFooterRefreshing) return;
    
    self.footerRefreshing = YES;
    self.footerLabel.text = @"正在加载更多数据";
    self.footerLabel.backgroundColor = [UIColor blueColor];
    
    //发送请求给服务器
    [self loadMoreData];
}

- (void)footerEndRefreshing {
    self.footerRefreshing = NO;
    self.footerLabel.text = @"上拉可以加载更多";
    self.footerLabel.backgroundColor = [UIColor redColor];
}
@end
