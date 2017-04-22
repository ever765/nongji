//
//  FaBuZhongTableViewCell.h
//  nongji
//
//  Created by 七云 on 2017/4/17.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaBuZhongTableViewCell : UITableViewCell
//根据index   显示不同的内容
- (void)drewContentViewWithIndexPathRRow:(NSInteger)index;
@end
