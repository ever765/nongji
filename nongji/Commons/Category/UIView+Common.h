//
//  UIView+Common.h
//  Leadinfo
//
//  Created by tobo on 16/9/19.
//  Copyright © 2016年 WDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)


CGFloat MaxY(UIView *view);
CGFloat MaxX(UIView *view);
CGFloat MinX(UIView *view);
CGFloat MinY(UIView *view);

CGFloat viewWidth(UIView *view);
CGFloat viewHeight(UIView *view);

CGFloat ScreenWidth();
CGFloat ScreenHeight();

@end
