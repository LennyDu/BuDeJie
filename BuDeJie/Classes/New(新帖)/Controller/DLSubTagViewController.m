//
//  DLSubTagViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/3.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLSubTagViewController.h"
#import "DLSubTagCell.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "DLSubTagItem.h"
#import <SVProgressHUD.h>
#import <MJRefresh.h>

@interface DLSubTagViewController ()
/** 存放模型数组 */
@property (nonatomic,strong) NSArray *subTagItems;
/** 会话请求管理者 */
@property (nonatomic,weak) AFHTTPSessionManager *mgr;
@end

@implementation DLSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"推荐标签";
    
    //提示用户正在加载数据
    [SVProgressHUD showWithStatus:@"正在加载数据......"];
    
    [self loadData];
    
    //自定义分割线
    //1.去掉系统默认分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //2.设置cell的背景色为默认分割线的颜色
    self.tableView.backgroundColor = [UIColor colorWithRed:220.0/255 green:220.0/255 blue:221.0/255 alpha:1];
    //3.将每个cell的最底部向上移动一个点
    
    [self setupRefresh];
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        DLFunc;
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    
    [_mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}

#pragma mark 从服务器你加载数据
- (void)loadData {
    //http://api.budejie.com/api/api_open.php
    //a tags_list
    //c subscribe
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    _mgr = mgr;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tags_list";
    parameters[@"c"] = @"subscribe";
    
    [mgr GET:DLCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject[@"rec_tags"]);
        
       _subTagItems = [DLSubTagItem mj_objectArrayWithKeyValuesArray:responseObject[@"rec_tags"]];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-----%@", error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    
    return _subTagItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DLSubTagCell";
    DLSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DLSubTagCell class]) owner:self options:nil] lastObject];
    }
    
    cell.item = _subTagItems[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
@end
