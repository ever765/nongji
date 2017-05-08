//
//  NewsListModel.h
//  nongji
//
//  Created by tobo on 17/5/2.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "BaseModel.h"

@interface NewsListModel : BaseModel

@property (nonatomic, strong)NSString <Optional>*createby;

@property (nonatomic, strong)NSString <Optional>*createtime;

@property (nonatomic, strong)NSString <Optional>*thumbnail;

@property (nonatomic, strong)NSString <Optional>*title;

@property (nonatomic, strong)NSString <Optional>*updateby;

@property (nonatomic, strong)NSString <Optional>*updatetime;

@property (nonatomic, strong)NSString <Optional>*content;

@end
