//
//  UIView+Common.m
//  Leadinfo
//
//  Created by tobo on 16/9/19.
//  Copyright © 2016年 WDX. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)

CGFloat MaxY(UIView *view){
    return CGRectGetMaxY(view.frame);
}
CGFloat MaxX(UIView *view){
    return CGRectGetMaxX(view.frame);
}
CGFloat MinX(UIView *view){
    return CGRectGetMinX(view.frame);
}
CGFloat MinY(UIView *view)
{
    return CGRectGetMinY(view.frame);
}


CGFloat viewWidth(UIView *view){
    return CGRectGetWidth(view.frame);
}
CGFloat viewHeight(UIView *view){
    return CGRectGetHeight(view.frame);
}


CGFloat ScreenWidth()
{
    return [[UIScreen mainScreen] bounds].size.width;
}
CGFloat ScreenHeight(){
    return [[UIScreen mainScreen] bounds].size.height;
}

@end
