//
//  IndentViewController.m
//  nongji
//
//  Created by Cus on 2017/4/19.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "IndentViewController.h"
#import "FaBuZhongViewController.h"
#import "IndentTableViewCell.h"
#import "WorkingViewController.h"
#include "IndentFinishViewController.h"
@interface IndentViewController ()
{
    NSMutableArray *_dataSource;
}
@end

@implementation IndentViewController
- (NSString *)navigationTitleText{
    return @"我的订单";
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    [self createButton];
    [self registerCellID];
    // Do any additional setup after loading the view.
}

- (void)createButton{
    NSArray *array = [NSArray arrayWithObjects:@"发布中", @"作业中", @"已完成", nil];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i * (self.view.frame.size.width/3) - 1, 64, self.view.frame.size.width/3, 40);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        button.backgroundColor = UIColorFromRGB(0xeeeeee);
        button.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        [self.view addSubview:button];
    }
    self.supportPullUpRefresh = YES;
    self.supportPullDownRefresh = YES;
    
}

- (void)registerCellID{
    [self.tableView registerClass:[IndentTableViewCell class] forCellReuseIdentifier:@"IndentTableViewCell_Id"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;//_mutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IndentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndentTableViewCell_Id" forIndexPath:indexPath];
    if (!cell) {
        cell = [[IndentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndentTableViewCell_Id"];
    }
    cell.status = arc4random()%3;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ViewWidth(200);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        WorkingViewController *vc = [[WorkingViewController alloc] init];
        PUSH
    }else if(indexPath.row == 0){
        IndentFinishViewController *vc = [[IndentFinishViewController alloc] init];
        PUSH
    }else{
        FaBuZhongViewController *faBuZhongViewController = [[FaBuZhongViewController alloc] init];
        [self.navigationController pushViewController:faBuZhongViewController animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- 设置tableview
- (void)pullDownRefreshData{
    NSLog(@"下啦刷新");
    sleep(2);
    [self finishPullDownRefresh:YES];
}

- (void)pullUpRefreshData{
    NSLog(@"上拉刷新");
    sleep(2);
    [self finishPullUpRefresh:YES hasMore:YES];
    
}

- (void)finishPullDownRefresh:(BOOL)succeed{
    [super finishPullDownRefresh:succeed];
}

- (void)finishPullUpRefresh:(BOOL)succeed hasMore:(BOOL)hasMore{
    [super finishPullUpRefresh:succeed hasMore:hasMore];
}

- (CGFloat)tableViewOriginY{
    return 104;
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
