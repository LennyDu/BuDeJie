//
//  DLSettingViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/1.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLSettingViewController.h"
#import "DLFileTool.h"
#import <SVProgressHUD.h>

@interface DLSettingViewController ()
/** 文件大小 */
@property (nonatomic,assign) NSInteger totalSize;
@end

@implementation DLSettingViewController

static NSString * const ID = @"UITableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"设置";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // Configure the cell...
    cell.textLabel.text = [self sizeStr];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    [DLFileTool removeDirectoryPath:cachePath];
    
    [self.tableView reloadData];
}

- (NSString *)sizeStr {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];

    [DLFileTool getFileSize:cachePath completion:^(NSInteger totalSize) {
        _totalSize = totalSize;
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    }];
    
    NSString *sizeStr = @"清除缓存";
    if (_totalSize > 1000 * 1000) {
        CGFloat sizeF = _totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"清除缓存(%.1fM)", sizeF];
    } else if (_totalSize > 1000) {
        CGFloat sizeF = _totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"清除缓存(%.1fKb)", sizeF];
    } else {
        sizeStr = [NSString stringWithFormat:@"清除缓存(%.1ldB)", (long)_totalSize];
    }
    
    return sizeStr;
}

@end
