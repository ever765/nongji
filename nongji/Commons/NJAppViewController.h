//
//  NJAppViewController.h
//  nongji
//
//  Created by tobo on 17/3/27.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJAppViewController : UIViewController
// 备用属性(用于将来显示loading)
@property (nonatomic, assign, getter=isFirstAppear) BOOL firstAppear;

// 自定义导航栏
@property (nonatomic, strong) UIView *customNavBar;

/**
 *  设置导航栏标题
 *  优先级: view > title
 *
 *  @return titleView or titleText
 */
- (UIView *)navigationTitleView;
- (NSString *)navigationTitleText;

/**
 *  设置导航栏左控件
 *  优先级：view > image > title
 *
 *  @return custom view,image or title
 */
- (UIView *)navigationLeftView;
- (UIImage *)navigationLeftImage;
- (NSString *)navigationLeftTitle;
- (void)navigationLeftAction:(id)sender;

/**
 *  设置导航栏右控件
 *  优先级: view > image > title
 *
 *  @return custom view, image or title
 */
- (UIView *)navigationRightView;
- (NSString *)navigationRightTitle;
- (UIImage *)navigationRightImage;
- (void)navigationRightAction:(id)sender;

//隐藏导航v
@property (nonatomic, assign)BOOL isHiddenNaVc;
@end
