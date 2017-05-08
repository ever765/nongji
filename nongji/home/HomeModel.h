//
//  HomeModel.h
//  nongji
//
//  Created by tobo on 17/5/2.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "BaseModel.h"




@protocol SliderModel
@end
@interface  SliderModel: BaseModel

@property (nonatomic, strong)NSString<Optional> *path;

@property (nonatomic, strong)NSString<Optional> *title;

@property (nonatomic, strong)NSString<Optional> *url;

@property (nonatomic, strong)NSString<Optional> *status;
@end
@protocol NewsModel
@end
@interface NewsModel : BaseModel
@property (nonatomic, strong)NSString<Optional> *title;

@property (nonatomic, strong)NSString<Optional> *type;

@property (nonatomic, strong)NSString<Optional> *thumbnail;

@property (nonatomic, strong)NSString<Optional> *content;

@property (nonatomic, strong)NSString<Optional> *status;

@property (nonatomic, strong)NSString<Optional> *createtime;

@property (nonatomic, strong)NSString<Optional> *createby;

@property (nonatomic, strong)NSString<Optional> *updatetime;

@property (nonatomic, strong)NSString<Optional> *updateby;
@end


@protocol ListModel
@end

@interface ListModel : BaseModel
//机手id
@property (nonatomic, strong)NSString <Optional>*list_id;
//机手姓名
@property (nonatomic, strong)NSString <Optional>*realName;
//作物品种
@property (nonatomic, strong)NSString <Optional>*serviceVri;
//作物类型
@property (nonatomic, strong)NSString <Optional>*serviceType;
//距离  默认米
@property (nonatomic, strong)NSString <Optional>*distance;
//头像
@property (nonatomic, strong)NSString <Optional>*headimage;
@end

@interface HomeModel : BaseModel
//农户入驻数量
@property (nonatomic, strong)NSString <Optional>*farmerNumber;
//机手入驻数量
@property (nonatomic, strong)NSString<Optional> *driverNumber;
//最近接单数量
@property (nonatomic, strong)NSString<Optional> *completeOrderNumber;
//最新信息
@property (nonatomic, strong)NSMutableArray <NewsModel,Optional> *news;
//banner
@property (nonatomic, strong)NSMutableArray <SliderModel,Optional> *slider;
//附近机手
@property (nonatomic, strong)NSMutableArray <ListModel,Optional> *list;


@end
