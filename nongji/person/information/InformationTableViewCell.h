//
//  InformationTableViewCell.h
//  nongji
//
//  Created by tobo on 17/5/3.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *titleLable;

@property (nonatomic,strong)UITextField *textField;

@property (nonatomic,strong)UIImageView *headerImageView;

- (void)addSubviewsWithindexRow:(NSIndexPath*)indexPath;

- (void)configureData:(NSArray*)titleLableArray  :(NSArray *)subTitleArray indexRow:(NSInteger)indexRow;
@end
