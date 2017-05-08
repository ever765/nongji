//
//  API.h
//  XiuCai
//
//  Created by tobo on 16/11/2.
//  Copyright © 2016年 WDX. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  enum HTTPMETHOD{
    
    METHOD_GET   = 0,    //GET请求
    METHOD_POST  = 1,    //POST请求
}HTTPMETHOD;

@interface API : NSObject

//直接传拼接好的地址
+(void)requestVerificationAFURL:(NSString *)URLString
         httpMethod:(HTTPMETHOD)method
         parameters:(id)parameters
      Authorization:(NSString *)header
     viewController:(UIViewController *)vc
            succeed:(void (^)(id responseObject))succeed
            failure:(void (^)(NSError *error))failure;
@end
