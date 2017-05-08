//
//  HistoricalOrderViewController.m
//  nongji
//
//  Created by Cus on 2017/4/12.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "HistoricalOrderViewController.h"
#import "CustomButton.h"
#import "HistoricalOrderTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#define ViewFrameOriginX ViewWidth(50)
@interface HistoricalOrderViewController ()
{
    CustomButton *_lastButton;
    NSMutableArray *_dataSource;
    NSInteger _pages;
}
@end

@implementation HistoricalOrderViewController
- (NSString *)navigationTitleText{
    return @"历史订单";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHeaderView];
    self.supportPullUpRefresh = YES;
    self.supportPullDownRefresh = YES;
    [self pullDownRefreshData];
    // Do any additional setup after loading the view.
}
- (void)createHeaderView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth(), ViewWidth(100))];
    
    CustomButton *allButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    allButton.frame = CGRectMake(ViewFrameOriginX, 0, ScreenWidth()/2 - ViewFrameOriginX *1.5, ViewWidth(78));
    [headerView addSubview:allButton];
    [allButton setTitle:@"全部订单" forState:UIControlStateNormal];
    [allButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [allButton setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    _lastButton = allButton;
    _lastButton.selected = YES;
    
    CustomButton *abnormalButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    abnormalButton.frame = CGRectMake(ScreenWidth()/2 +ViewFrameOriginX /2 , 0, ScreenWidth()/2  - ViewFrameOriginX *1.5, ViewWidth(78));
    [abnormalButton setTitle:@"异常订单" forState:UIControlStateNormal];
    [abnormalButton setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    [abnormalButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [headerView addSubview:abnormalButton];
    [self.view addSubview:headerView];
  
}

- (CGFloat)tableViewOriginY{
    return 64 + ViewWidth(78);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoricalOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoricalOrderTableViewCell_ID"];
    if (!cell) {
        cell = [[HistoricalOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoricalOrderTableViewCell_ID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ViewWidth(200);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---- 设置tableview
- (void)pullDownRefreshData{
    [_dataSource removeAllObjects];
    _pages = 1;
    NSString *url = [NSString stringWithFormat:@"%@farmer/orders?page=%ld&rows=20&userId=%@&state=%@",NONGJIURL,_pages,GETUSERID,@"1"];
    [API requestVerificationAFURL:url httpMethod:METHOD_GET parameters:nil Authorization:nil viewController:self succeed:^(id responseObject) {
        if (responseObject) {
            
        }
        [self finishPullDownRefresh:YES];
    } failure:^(NSError *error) {
        [self finishPullDownRefresh:YES];
    }];
    
    
}

- (void)pullUpRefreshData{
    NSString *url;
    _pages++;
    url = [NSString stringWithFormat:@"%@farmer/orders?page=%ld&rows=20&userId=%@&state=%@",NONGJIURL,_pages,GETUSERID,@"1"];
    [API requestVerificationAFURL:url httpMethod:METHOD_GET parameters:nil Authorization:nil viewController:self succeed:^(id responseObject) {
        if (responseObject) {
            _dataSource = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",_dataSource);
        }
        [self finishPullUpRefresh:YES hasMore:YES];
    } failure:^(NSError *error) {
        [self finishPullUpRefresh:YES hasMore:YES];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

- (void)finishPullDownRefresh:(BOOL)succeed{
    [super finishPullDownRefresh:succeed];
}

- (void)finishPullUpRefresh:(BOOL)succeed hasMore:(BOOL)hasMore{
    [super finishPullUpRefresh:succeed hasMore:hasMore];
}

- (void)buttonAction:(UIButton *)button{
    if (![button isEqual:_lastButton]) {
        _lastButton.selected = NO;
        _lastButton = (CustomButton *)button;
        _lastButton.selected = YES;
    }
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
