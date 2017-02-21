//
//  DLAllTableViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/20.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLAllTableViewController.h"
#import <AFNetworking.h>
#import "DLTopicItem.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>

#import "DLTopicCell.h"

@interface DLAllTableViewController ()
/** 请求管理者 */
@property (nonatomic,strong) AFHTTPSessionManager *manager;
/** 当前最后一条帖子数据的描述信息, 专门用来加载下一页, 这个标识可以识别下一页的数据 */
@property (nonatomic,copy) NSString *maxtime;
/** 所有的帖子数据 */
@property (nonatomic,strong) NSMutableArray *topics;

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

static NSString *const DLTopicCellId = @"DLTopicCellId";

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DLRandomColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(DLNavMaxY + DLTitlesViewH, 0, DLTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.rowHeight = 200;
    
    //注册cell
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([DLTopicCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:DLTopicCellId];
    
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
    self.footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:DLTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
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
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSLog(@"发送请求给服务器, 下拉刷新数据");
    //1.创建请求会话管理者
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"41";
    
    //3.发送请求
    [self.manager GET:DLCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [DLTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        
        [self headerEndRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if (error.code != NSURLErrorCancelled) {
            [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试!"];
        }
        
        [self headerEndRefreshing];
    }];
}

- (void)loadMoreData {
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //1.创建请求会话管理者
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"41";
    parameters[@"maxtime"] = self.maxtime;
    
    //3.发送请求
    [self.manager GET:DLCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *moreTopics = [DLTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        [self.tableView reloadData];
        
        [self footerEndRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) {
            [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试!"];
        }
        
        [self footerEndRefreshing];
    }];
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
