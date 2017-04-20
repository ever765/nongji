//
//  NJTabbarView.h
//  nongji
//
//  Created by tobo on 17/3/27.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import <UIKit/UIKit.h>


@class NJTabbarView;

@protocol NJTabbarViewDelegate <NSObject>

@optional

- (void)tabBar:(NJTabbarView *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag;

- (void)tabBarClickWriteButton:(NJTabbarView *)tabBar;

@end

@interface NJTabbarView : UIView

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem;
@property(nonatomic, weak)id <NJTabbarViewDelegate>delegate;

@end
