//
//  NSString+Common.h
//  registerDemo
//
//  Created by tobo on 16/10/17.
//  Copyright © 2016年 WDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>
@interface NSString (Common)

//检查用户是否为手机号注册
+ (BOOL)stringIsLoginUser:(NSString *)str withViewController:(UIViewController *)viewController;
//字符串是否为空   是:yes  否:no
+ (BOOL)stringIsNil:(NSString *)str withViewController:(UIViewController *)viewController withMessage:(NSString *)message;
//登录密码
+ (BOOL)stringIsLoginPassWord:(NSString *)str withViewController:(UIViewController *)viewController;
//检测是否是身份证号
+ (BOOL)stringIsIdentity:(NSString *)str withViewController:(UIViewController *)viewController;
//检测是支付密码
+ (BOOL)stringPayPassword:(NSString *)str withViewController:(UIViewController *)viewController;
//MD5加密
NSString * MD5Hash(NSString *aString);
//  get请求  需要包含汉字
NSString * URLEncodedString(NSString *str);
//把一个秒字符串 转化为真正的本地时间
//  1432861705000
//@"1419055200" -> 转化 日期字符串
+ (NSString *)dateStringFromNumberTimer:(NSString *)timerStr;


@end
