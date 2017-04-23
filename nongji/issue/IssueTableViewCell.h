//
//  IssueTableViewCell.h
//  nongji
//
//  Created by tobo on 17/4/21.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *titleLable;

@property (nonatomic,strong)UITextField *textField;

@property (nonatomic,strong)UITextView *textView;

- (void)addSubviewsWithindexRow:(NSInteger)indexRow;

- (void)configureData:(NSArray*)titleLableArray  :(NSArray *)subTitleArray indexRow:(NSInteger)indexRow;

@end
