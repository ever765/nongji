//
//  NJBaseTableViewController.h
//  nongji
//
//  Created by Cus on 2017/4/19.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "NJAppViewController.h"

@interface NJBaseTableViewController : NJAppViewController<UITableViewDelegate, UITableViewDataSource>

// 是否支持下拉刷新
@property (nonatomic, assign, getter=isSupportPullDownRefresh) BOOL supportPullDownRefresh;

// 是否支持上拉刷新
@property (nonatomic, assign, getter=isSupportPullUpRefresh) BOOL supportPullUpRefresh;

// 基类tableView
@property (nonatomic, strong) UITableView *tableView;

// 子类接口部分
//下拉刷新调用
- (void)pullDownRefreshData;
//上拉刷新调用
- (void)pullUpRefreshData;
//下拉刷新停止
- (void)finishPullDownRefresh:(BOOL)succeed;
//上拉刷新停止
- (void)finishPullUpRefresh:(BOOL)succeed hasMore:(BOOL)hasMore;
//
- (UITableViewStyle)tableViewStyle;
//
- (CGFloat)tableViewOriginY;
//
- (CGFloat)tableViewBottomPadding;



@end
