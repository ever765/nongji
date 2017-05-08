//
//  HomeTableViewCell.h
//  nongji
//
//  Created by tobo on 17/4/24.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;
@class ListModel;
@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, strong) NewsModel *model;

@property (nonatomic, strong)ListModel *mode;
@end
