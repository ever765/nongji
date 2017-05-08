//
//  HomeModel.m
//  nongji
//
//  Created by tobo on 17/5/2.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

@end

@implementation ListModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"list_id"}];
}
@end
@implementation SliderModel

@end

@implementation NewsModel

@end
