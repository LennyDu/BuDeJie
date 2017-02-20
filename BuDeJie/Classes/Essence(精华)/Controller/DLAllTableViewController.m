//
//  DLAllTableViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/20.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLAllTableViewController.h"

@interface DLAllTableViewController ()

@end

@implementation DLAllTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DLRandomColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(DLNavMaxY + DLTitlesViewH, 0, DLTabBarH, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:DLTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:DLTitleButtonDidRepeatClickNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    return 30;
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

@end
