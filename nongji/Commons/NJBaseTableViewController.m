//
//  NJBaseTableViewController.m
//  nongji
//
//  Created by Cus on 2017/4/19.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "NJBaseTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <Masonry.h>
#import "AHSKitMacro.h"

@interface NJBaseTableViewController ()

@end

@implementation NJBaseTableViewController

#pragma mark -- setter && getter
- (void)setSupportPullDownRefresh:(BOOL)supportPullDownRefresh
{
    _supportPullDownRefresh = supportPullDownRefresh;
    if (_supportPullDownRefresh && self.tableView.mj_header == nil) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefreshData)];
    } else {
        [self.tableView.mj_header removeFromSuperview];
    }
}

- (void)setSupportPullUpRefresh:(BOOL)supportPullUpRefresh
{
    _supportPullUpRefresh = supportPullUpRefresh;
    if (_supportPullUpRefresh && self.tableView.mj_footer == nil) {
        self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpRefreshData)];
    } else {
        [self.tableView.mj_footer removeFromSuperview];
    }
}

- (void)finishPullDownRefresh:(BOOL)succeed
{
    if (self.isSupportPullDownRefresh) {
        [self.tableView.mj_header endRefreshing];
    }
}

- (void)finishPullUpRefresh:(BOOL)succeed hasMore:(BOOL)hasMore
{
    if (self.isSupportPullUpRefresh) {
        [self.tableView.mj_footer endRefreshing];
        hasMore ? : [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark -- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _configTableView];
    
    [self _addConstraintsForTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- private
- (void)_configTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:[self tableViewStyle]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    //    self.tableView.backgroundColor = [UIColor colorWithHex:0xf2f2f2];
    [self.view addSubview:self.tableView];
}

- (void)_addConstraintsForTableView
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset([self tableViewOriginY]);
        if ([self tableViewBottomPadding] > 0) {
            make.bottom.mas_equalTo(- [self tableViewBottomPadding]);
        }else {
            make.bottom.equalTo(self.hidesBottomBarWhenPushed ? self.mas_bottomLayoutGuideBottom : self.mas_bottomLayoutGuideTop);
        }
    }];
}

- (void)reloadButtonAction {
    
    [self pullDownRefreshData];
}

#pragma mark -- public
- (void)pullDownRefreshData
{
    
}

- (void)pullUpRefreshData
{
    
}

- (UITableViewStyle)tableViewStyle
{
    return UITableViewStylePlain;
}

- (CGFloat)tableViewOriginY
{
    return KNAV_HEIGHT;
}

- (CGFloat)tableViewBottomPadding {
    return 0;
}


#pragma mark -- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
