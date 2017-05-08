//
//  API.m
//  XiuCai
//
//  Created by tobo on 16/11/2.
//  Copyright © 2016年 WDX. All rights reserved.
//

#import "API.h"
//#import "Common.h"
#import <AFNetworking/AFNetworking.h>
@implementation API

/**
 * AF网络请求
 */

+(void)requestVerificationAFURL:(NSString *)URLString
                     httpMethod:(HTTPMETHOD)method
                     parameters:(id)parameters
                  Authorization:(NSString *)header
                 viewController:(UIViewController *)vc
                        succeed:(void (^)(id responseObject))succeed
                        failure:(void (^)(NSError *error))failure

{
    //    // 0.设置API地址
    //    URLString = [NSString stringWithFormat:@"%@%@",MANAGERMONEYAPI,URLString];
    NSLog(@"\n AF网络请求参数列表:%@\n\n 接口名: %@\n\n",parameters,URLString);
    
    // 1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2.申明返回的结果是二进制类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
    // 3.如果报接受类型不一致请替换一致text/html  或者 text/plain
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    // 4.请求超时，时间设置
    manager.requestSerializer.timeoutInterval = 15;
    
    // 5.选择请求方式 GET 或 POST
    switch (method) {
        case METHOD_GET:
        {
            [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *dict =   [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dict);
                if ([dict[@"status"] isEqualToString:@"OK"]) {
                    succeed(responseObject);
                }else{
                    [vc showHint:dict[@"message"]];
                    succeed(nil);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                failure(error);
                [vc showHint:@"请求失败"];
                NSLog(@"\n 请求失败:%@\n\n",error);
            }];
        }
            break;
            
        case METHOD_POST:
        {
            NSLog(@"%@",parameters);
            [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *dict =   [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dict);
                if ([dict[@"status"] isEqualToString:@"OK"]) {
                    succeed(responseObject);
                }else{
                    [vc showHint:dict[@"message"]];
                    succeed(nil);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                
                failure(error);
                [vc showHint:@"请求失败"];
                
            }];
        }
            break;
            
        default:
            break;
    }
}
@end
