//
//  MyTools.h
//  XiuCai
//
//  Created by tobo on 16/10/20.
//  Copyright © 2016年 WDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyTools : NSObject
+(UIView *)lineView:(UIColor *)color :(CGRect)frame;
+(UILabel *)lableWithtextColor:(UIColor *)clor textFont:(UIFont *)font inSize:(CGSize)size withText:(NSString *)text;
+ (NSString *)getBytesFromDataLength:(NSInteger)dataLength;
+ (UIImage *)fixOrientation:(UIImage *)aImage;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSData *)getImageCompress:(UIImage *)image;

@end
