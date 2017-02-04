//
//  DLFastLoginView.m
//  BuDeJie
//
//  Created by Lenny on 2017/2/4.
//  Copyright © 2017年 Lenny. All rights reserved.
//

#import "DLFastLoginView.h"

@implementation DLFastLoginView

+ (instancetype)fastLoginView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
