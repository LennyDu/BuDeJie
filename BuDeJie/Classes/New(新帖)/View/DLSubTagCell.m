//
//  DLSubTagCell.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/3.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLSubTagCell.h"
#import "DLSubTagItem.h"
#import <UIImageView+WebCache.h>

@interface DLSubTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *tagNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation DLSubTagCell

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)setItem:(DLSubTagItem *)item {
    _item = item;
    
    _tagNameLabel.text = item.theme_name;
    
    NSString *subNumberString = [NSString stringWithFormat:@"%@人订阅",item.sub_number];
    CGFloat num = [item.sub_number floatValue];
    if (num > 9999) {
        num = num / 10000.0;
        subNumberString = [NSString stringWithFormat:@"%.1f万人订阅",num];
        subNumberString = [subNumberString stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    _subNumberLabel.text = subNumberString;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width * 0.5;
    self.iconImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
