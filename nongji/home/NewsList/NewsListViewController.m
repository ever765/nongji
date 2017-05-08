//
//  NewsListViewController.m
//  nongji
//
//  Created by tobo on 17/5/2.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "NewsListViewController.h"
#import "CustomButton.h"
#import "NewsTableViewCell.h"
#import "NewsListModel.h"
#import <MJRefresh/MJRefresh.h>
#import "NewsDetialViewController.h"
#define ViewFrameOriginX ViewWidth(50)

@interface NewsListViewController ()
{
    CustomButton *_lastButton;
    NSInteger _LodingType;
    NSInteger _pages;
    BOOL _isNews;
    NSMutableArray *_dataSource;
}
@end

@implementation NewsListViewController

- (NSString *)navigationTitleText{
    return @"最新资讯";
}

- (CGFloat)tableViewOriginY{
    return 64 + ViewWidth(79);
}
- (CGFloat)tableViewBottomPadding{
    return 0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isNews = YES;
    _dataSource = [[NSMutableArray alloc] init];
    self.supportPullUpRefresh = YES;
    self.supportPullDownRefresh = YES;
    [self createHeaderView];
    // Do any additional setup after loading the view.
}


- (void)createHeaderView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth(), ViewWidth(100))];
    
    CustomButton *allButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    allButton.frame = CGRectMake(ViewFrameOriginX, 0, ScreenWidth()/2 - ViewFrameOriginX *1.5, ViewWidth(78));
    [headerView addSubview:allButton];
    allButton.tag = 100;
    [allButton setTitle:@"农户新闻" forState:UIControlStateNormal];
    [allButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [allButton setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    _lastButton = allButton;
    _lastButton.selected = YES;
    
    CustomButton *abnormalButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    abnormalButton.frame = CGRectMake(ScreenWidth()/2 +ViewFrameOriginX /2 , 0, ScreenWidth()/2  - ViewFrameOriginX *1.5, ViewWidth(78));
    abnormalButton.tag = 101;
    [abnormalButton setTitle:@"政府补贴" forState:UIControlStateNormal];
    [abnormalButton setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    [abnormalButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [headerView addSubview:abnormalButton];
    [self.view addSubview:headerView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, MaxY(allButton), ScreenWidth(), ViewWidth(2))];;
    lineView.backgroundColor = LINECOLOR;
    [headerView addSubview:lineView];
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"cellId%ld",indexPath.section];
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.model = _dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ViewWidth(88);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetialViewController *vc = [[NewsDetialViewController alloc] init];
    vc.model = _dataSource[indexPath.row];
    PUSH;
}

- (void)buttonAction:(UIButton *)button{
    if (![button isEqual:_lastButton]) {
        _lastButton.selected = NO;
        _lastButton = (CustomButton *)button;
        _lastButton.selected = YES;
        _isNews = !_isNews;
        [self.tableView.mj_header beginRefreshing];
    }
    
}

#pragma mark ---- 设置tableview
- (void)pullDownRefreshData{
    [_dataSource removeAllObjects];
    NSString *url;
    _pages = 1;
    if (_isNews) {
        url = [NSString stringWithFormat:@"%@news?type=1&page=1&rows=20",NONGJIURL];
    }else{
        url = [NSString stringWithFormat:@"%@news?type=2&page=1&rows=20",NONGJIURL];
    }
    [API requestVerificationAFURL:url httpMethod:METHOD_GET parameters:nil Authorization:nil viewController:self succeed:^(id responseObject) {
        if (responseObject) {
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            for (NSDictionary *dic in dict[@"message"][@"list"]) {
                NewsListModel *model = [[NewsListModel alloc] initWithDictionary:dic error:nil];
                [_dataSource addObject:model];
            }
            [self.tableView reloadData];
        }
        [self finishPullDownRefresh:YES];
    } failure:^(NSError *error) {
        [self finishPullDownRefresh:YES];
    }];
    
    
}

- (void)pullUpRefreshData{
    NSString *url;
    _pages++;
    if (_isNews) {
        url = [NSString stringWithFormat:@"%@news?type=1&page=%ld&rows=20",NONGJIURL,_pages];
    }else{
        url = [NSString stringWithFormat:@"%@news?type=2&page=%ld&rows=20",NONGJIURL,_pages];
    }
    [API requestVerificationAFURL:url httpMethod:METHOD_GET parameters:nil Authorization:nil viewController:self succeed:^(id responseObject) {
        if (responseObject) {
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            for (NSDictionary *dic in dict[@"message"][@"list"]) {
                NewsListModel *model = [[NewsListModel alloc] initWithDictionary:dic error:nil];
                [_dataSource addObject:model];
            }
            [self.tableView reloadData];
        }
        [self finishPullUpRefresh:YES hasMore:YES];
    } failure:^(NSError *error) {
        [self finishPullUpRefresh:YES hasMore:YES];
    }];
    
    
}

- (void)finishPullDownRefresh:(BOOL)succeed{
    [super finishPullDownRefresh:succeed];
}

- (void)finishPullUpRefresh:(BOOL)succeed hasMore:(BOOL)hasMore{
    [super finishPullUpRefresh:succeed hasMore:hasMore];
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
