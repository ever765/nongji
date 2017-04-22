//
//  IndentFinishTableViewCell.h
//  nongji
//
//  Created by tobo on 17/4/21.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndentFinishTableViewCell : UITableViewCell

//根据index   显示不同的内容
- (void)drewContentViewWithIndexPathRRow:(NSInteger)index;

@end
