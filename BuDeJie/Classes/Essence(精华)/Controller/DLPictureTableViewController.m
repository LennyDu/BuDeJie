//
//  DLPictureTableViewController.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/20.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLPictureTableViewController.h"

@interface DLPictureTableViewController ()

@end

@implementation DLPictureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DLRandomColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(DLNavMaxY + DLTitlesViewH, 0, DLTabBarH, 0);
    
    DLFunc;
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
