//
//  DLSquareCollectionViewCell.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/5.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLSquareCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "DLSquareItem.h"

@interface DLSquareCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation DLSquareCollectionViewCell

- (void)setItem:(DLSquareItem *)item {
    _item = item;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameLabel.text = item.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
