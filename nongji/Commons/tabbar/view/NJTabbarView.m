//
//  NJTabbarView.m
//  nongji
//
//  Created by tobo on 17/3/27.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "NJTabbarView.h"

#import "NJTabbarButton.h"

@interface NJTabbarView ()
@property(nonatomic, strong)NSMutableArray *tabbarBtnArray;
@property(nonatomic, weak)UIButton *writeButton;
@property(nonatomic, weak)NJTabbarButton *selectedButton;
@end

@implementation NJTabbarView
- (NSMutableArray *)tabbarBtnArray{
    if (!_tabbarBtnArray) {
        _tabbarBtnArray = [NSMutableArray array];
    }
    return  _tabbarBtnArray;
}

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self SetupWriteButton];
    }
    
    return self;
}
//创建发布按钮
- (void)SetupWriteButton{
    UIButton *writeButton = [UIButton new];
    writeButton.adjustsImageWhenHighlighted = NO;
    [writeButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [writeButton addTarget:self action:@selector(ClickWriteButton) forControlEvents:UIControlEventTouchUpInside];
    writeButton.bounds = CGRectMake(0, self.frame.size.height  + 10 - writeButton.currentBackgroundImage.size.height, writeButton.currentBackgroundImage.size.width, writeButton.currentBackgroundImage.size.height);
    writeButton.backgroundColor = UIColorFromRGB(0xffffff);
    writeButton.layer.masksToBounds = YES;
    writeButton.layer.borderWidth = 4;
    writeButton.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    writeButton.layer.cornerRadius = writeButton.bounds.size.height/2;
    [self addSubview:writeButton];
    _writeButton = writeButton;
}
//设置按钮的位置
- (void)layoutSubviews{
    [super layoutSubviews];
    self.writeButton.center = CGPointMake(self.frame.size.width*0.5, _writeButton.center.y);
    
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width/(self.subviews.count);
    CGFloat btnH = self.frame.size.height;
    
    for (int nIndex = 0; nIndex < self.tabbarBtnArray.count; nIndex++) {
        CGFloat btnX = btnW * nIndex;
        NJTabbarButton *tabBarBtn = self.tabbarBtnArray[nIndex];
        if (nIndex > 1) {
            btnX += btnW;
        }
        tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        tabBarBtn.tag = nIndex;
    }
}
//  添加
- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem{
    NJTabbarButton *tabBarBtn = [[NJTabbarButton alloc] init];
    tabBarBtn.tabBarItem = tabBarItem;
    [tabBarBtn addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarBtn];
    [self.tabbarBtnArray addObject:tabBarBtn];
    
    //default selected first one
    if (self.tabbarBtnArray.count == 1) {
        [self ClickTabBarButton:tabBarBtn];
    }
}

- (void)ClickTabBarButton:(NJTabbarButton *)tabBarBtn{
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:tabBarBtn.tag];
    }
    
    self.selectedButton.selected = NO;
    tabBarBtn.selected = YES;
    self.selectedButton = tabBarBtn;
}

- (void)ClickWriteButton{
    if ([self.delegate respondsToSelector:@selector(tabBarClickWriteButton:)]) {
        [self.delegate tabBarClickWriteButton:self];
    }
}/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
