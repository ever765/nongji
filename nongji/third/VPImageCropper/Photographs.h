//
//  Photographs.h
//  XiuCai
//
//  Created by tobo on 16/10/18.
//  Copyright © 2016年 WDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Photographs : NSObject


/**
 *  打开照相机 或相册
 *
 *  @param avatarView     将要修改的图片位置
 *  @param viewController 将要显示在那个ViewController上显示
 */
-(void)changeAvatar:(UIImageView *) avatarView withViewController:(UIViewController *)viewController withUrl:(NSString *)url;

@end
