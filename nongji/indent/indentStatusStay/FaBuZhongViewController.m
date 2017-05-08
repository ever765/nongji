//
//  FaBuZhongViewController.m
//  nongji
//
//  Created by 七云 on 2017/4/17.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "FaBuZhongViewController.h"
#import "FaBuZhongTableViewCell.h"
#import "IssueSetViewController.h"
#import "CancelIssueViewController.h"
@interface FaBuZhongViewController ()

@end

@implementation FaBuZhongViewController

- (NSString *)navigationTitleText{
    return @"订单详情";
}

- (UIImage *)navigationRightImage{
    return [UIImage imageNamed:@"close"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerCellID];
    
}
- (void)registerCellID{
    [self.tableView registerClass:[FaBuZhongTableViewCell class] forCellReuseIdentifier:@"FaBuZhongTableViewCell_Id"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FaBuZhongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FaBuZhongTableViewCell_Id"];
    if (!cell) {
        cell = [[FaBuZhongTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FaBuZhongTableViewCell_Id"];
    }
    [cell drewContentViewWithIndexPathRRow:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3 || indexPath.row == 8){
        return ViewWidth(150);
    }
    return ViewWidth(88);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >9) {
        IssueSetViewController *vc = [[IssueSetViewController alloc] init];
        PUSH;
    }
}

- (void)navigationRightAction:(id)sender{
    CancelIssueViewController *vc = [[CancelIssueViewController alloc] init];
    PUSH;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
