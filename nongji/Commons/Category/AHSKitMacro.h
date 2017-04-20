//
//  AHSKitMacro.h
//  nongji
//
//  Created by Cus on 2017/4/18.
//  Copyright © 2017年 WDX. All rights reserved.
//

#ifndef AHSKitMacro_h
#define AHSKitMacro_h

#define kSCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define kSCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width

#define KNAV_HEIGHT 64.f
#define KNAVBAR_HEIGHT 44.f
#define KSTATUS_HEIGHT 20.f
#define KNAV_BUTTON_WIDTH 60.f
//16进制转换rgb
#define UIColorFromRGB(rgbValue) [[UIColor alloc] initWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:1.0]

#endif /* AHSKitMacro_h */
