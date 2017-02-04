//
//  DLLoginRegisterView.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/4.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLLoginRegisterView.h"

@interface DLLoginRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;

@end

@implementation DLLoginRegisterView

+ (instancetype)loginView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImage *image = _loginRegisterButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    [_loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
    
    UIImage *highlightImage = [UIImage imageNamed:@"loginBtnBgClick"];
    highlightImage = [highlightImage stretchableImageWithLeftCapWidth:highlightImage.size.width * 0.5 topCapHeight:highlightImage.size.height * 0.5];
    [_loginRegisterButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
}

@end
