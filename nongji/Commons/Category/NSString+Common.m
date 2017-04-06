//
//  NSString+Common.m
//  registerDemo
//
//  Created by tobo on 16/10/17.
//  Copyright © 2016年 WDX. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)
//注册密码   是:yes  否:no
+ (BOOL)stringIsNil:(NSString *)str withViewController:(UIViewController *)viewController withMessage:(NSString *)message
{
    if (str.length == 0) {
        if (message) {
            [self message:message withController:viewController];
        }
        return NO;
    }
    return YES;
}

//是否身份证号   是：yes 否：no
/*
 15位数身份证验证正则表达式：
 isIDCard1=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
 
 18位数身份证验证正则表达式 ：
 isIDCard2=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
 */

+(BOOL)stringIsIdentity:(NSString *)str withViewController:(UIViewController *)viewController
{
    if ([self stringIsNil:str withViewController:viewController withMessage:@"身份证输入不能为空"]) {
        return NO;
    }
    
    NSString *regex;
    if (str.length == 15) {
        regex = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    }else{
        regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    }
//    regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        [self message:@"身份证号输入有误" withController:viewController];
        return NO;
    }
    return YES;
}
//检查用户是否为手机号注册
/**
 * 验证手机号码（支持国际格式，+86135xxxx...（中国内地），+00852137xxxx...（中国香港））
 *
 * @param mobile 移动、联通、电信运营商的号码段
 *               <p>
 *               移动的号段：134(0-8)、135、136、137、138、139、147（预计用于TD上网卡）
 *               、150、151、152、157（TD专用）、158、159、187（未启用）、188（TD专用）
 *               </p>
 *               <p>
 *               联通的号段：130、131、132、155、156（世界风专用）、185（未启用）、186（3g）
 *               </p>
 *               <p>
 *               电信的号段：133、153、180（未启用）、189
 *               </p>
 * @return 验证成功返回true，验证失败返回false
 */
+ (BOOL)stringIsLoginUser:(NSString *)str withViewController:(UIViewController *)viewController
{
    if ([self stringIsNil:str withViewController:viewController withMessage:@"手机号不能为空"]) {
        return NO;
    }
    NSString *regex = @"(\\+\\d+)?1[34578]\\d{9}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        [self message:@"手机号输入格式错误" withController:viewController];
        return NO;
    }

    return YES;
}
//登录密码
+ (BOOL)stringIsLoginPassWord:(NSString *)str withViewController:(UIViewController *)viewController
{
    if ([self stringIsNil:str withViewController:viewController withMessage:@"密码不能为空"]) {
        return NO;
    }
    NSString *regex = @"(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]{6,}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        [self message:@"密码格式不正确" withController:viewController];
        return NO;
    }
    return YES;
}
//检测是支付密码
+ (BOOL)stringPayPassword:(NSString *)str withViewController:(UIViewController *)viewController
{
    if ([self stringIsNil:str withViewController:viewController withMessage:@"支付密码为空"]) {
        return NO;
    }
    if (str.length != 6) {
        [self message:@"请输入完整的支付密码" withController:viewController];
        return NO;
    }
    return YES;
}
/**
 *  弹窗提示
 *
 *  @param str            提示信息
 *  @param viewController 在那个窗口弹窗

 */
+ (void)message:(NSString *)str withController:(UIViewController *)viewController
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [viewController presentViewController:alert animated:YES completion:^{
        
    }];
    
}
//MD5加密  xiucai   需求前面添加4个0再进行加密
NSString * MD5Hash(NSString *aString) {
    NSString *str = [NSString stringWithFormat:@"0000%@",aString];
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

NSString * URLEncodedString(NSString *str) {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[str UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+ (NSString *)dateStringFromNumberTimer:(NSString *)timerStr {
    NSString *date1 = timerStr;
    NSString *newDate = [date1 substringToIndex:10];
    //转化为Double
    double t = [newDate doubleValue];
    //计算出距离1970的NSDate
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t];
    //转化为 时间格式化字符串
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd";
    //转化为 时间字符串
    return [df stringFromDate:date];
}
@end
