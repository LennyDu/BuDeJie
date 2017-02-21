//
//  DLMeTableViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/1/31.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLMeTableViewController.h"
#import "UIBarButtonItem+Item.h"
#import "DLSettingViewController.h"
#import "DLSquareCollectionViewCell.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "DLSquareItem.h"
#import <SafariServices/SafariServices.h>

#import "DLWebViewController.h"

NSString * const cellId = @"UICollectionViewCell";
NSInteger const cols = 4;
CGFloat const margin = 1;
#define itemWH (DLScreenW - (cols - 1) * margin) / cols

@interface DLMeTableViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SFSafariViewControllerDelegate>
/** items */
@property (nonatomic,strong) NSMutableArray *items;

/** collectionView */
@property (nonatomic,weak) UICollectionView *collectionView;
@end

@implementation DLMeTableViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条
    [self setupNavBar];
    
    //设置FooterView
    [self setupFooterView];
    
    //加载方格内的数据
    [self loadData];
    
    //处理tableview的section间距过大的问题
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:DLTabBarButtonDidRepeatClickNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听
- (void)tabBarButtonDidRepeatClick {
    if (self.view.window == nil) return;
    NSLog(@"%@ - 刷新数据", self.class);
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    NSLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
//}


// 最后一行数据没占满一行的时候进行不全操作
- (void)repairSquareGap {
    NSInteger itemCount = _items.count;
    NSInteger exter = itemCount % cols;
    if (exter) {
        NSInteger gapCount = cols - exter;
        for (int i = 0; i < gapCount; i++) {
            DLSquareItem *item = [[DLSquareItem alloc] init];
            [_items addObject:item];
        }
    }
}

- (void)loadData {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [mgr GET:DLCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *square_list = responseObject[@"square_list"];
        _items = [DLSquareItem mj_objectArrayWithKeyValuesArray:square_list];
        
        [self repairSquareGap];
        
        [_collectionView reloadData];
        
        NSInteger count = _items.count;
        NSInteger rows = (count - 1) / cols + 1;
        _collectionView.dl_height = rows * itemWH + (rows - 1) * margin;
        
        self.tableView.tableFooterView = _collectionView;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)setupFooterView {
    //collectionView使用注意:
    //1.需要布局文件
    //2.需要自定义cell
    //3.cell需要注册
    
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    
    collectionViewLayout.itemSize = CGSizeMake(itemWH, itemWH);
    collectionViewLayout.minimumInteritemSpacing = margin;
    collectionViewLayout.minimumLineSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:collectionViewLayout];
    collectionView.scrollEnabled = NO;
    _collectionView = collectionView;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DLSquareCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellId];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = collectionView;
}

- (void)setupNavBar
{
    // 左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    
    // 设置
    UIBarButtonItem *settingItem =  [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    // 夜间模型
    UIBarButtonItem *nightItem =  [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    
    // titleView
    self.navigationItem.title = @"我的";
    
}

- (void)night:(UIButton *)button
{
    button.selected = !button.selected;
    
}

- (void)setting
{
    //跳转到设置页面
    DLSettingViewController *settingVc = [[DLSettingViewController alloc] init];
    //所有的自控制器都需要隐藏底部,所以可以在pushViewController中来处理这个操作
    //    settingVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewControllerDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSLog(@"%@", NSStringFromCGRect([tableView cellForRowAtIndexPath:indexPath].frame));
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DLSquareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.item = _items[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DLSquareItem *item = self.items[indexPath.row];
    if (![item.url containsString:@"http"]) return;
    
    NSURL *url = [NSURL URLWithString:item.url];
//    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
//    [self presentViewController:safariVC animated:YES completion:nil];
    
    DLWebViewController *webVC = [[DLWebViewController alloc] init];
    webVC.url = url;
    [self.navigationController pushViewController:webVC animated:YES];
    
}


#pragma mark - SFSafariViewControllerDelegate
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
