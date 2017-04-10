//
//  BaseViewController.h
//  nongji
//
//  Created by tobo on 17/3/27.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "NJAppViewController.h"

@interface BaseViewController : NJAppViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
}

@end
