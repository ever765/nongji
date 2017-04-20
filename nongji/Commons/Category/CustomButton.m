//
//  CustomButton.m
//  nongji
//
//  Created by Cus on 2017/4/12.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton
UIView *_view;

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (!_view) {
        _view = [[UIView alloc] initWithFrame:CGRectMake(0,  ViewWidth(75), self.frame.size.width, ViewWidth(2))];
        _view.backgroundColor = UIColorFromRGB(0x333333);
    }
    if (selected) {
        [self setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateSelected];
        [self addSubview:_view];
    }else{
        [_view removeFromSuperview];
        [self setTitleColor:UIColorFromRGB(0xeeeeee) forState:UIControlStateNormal];
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
