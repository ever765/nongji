//
//  MySetViewController.m
//  nongji
//
//  Created by tobo on 17/4/11.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "MySetViewController.h"
#import "MySetTableViewCell.h"
#import "AboutAppViewController.h"
@interface MySetViewController ()

@end

@implementation MySetViewController

- (void)viewDidLoad {
    self.vcTitle = @"设置";
    [super viewDidLoad];
    [self registerCellID];
    // Do any additional setup after loading the view.
}
- (void)registerCellID{
    _tableView.frame = CGRectMake(0, ViewWidth(60) + 64, ScreenWidth(), ScreenHeight() - 64 - ViewWidth(60));
    _tableView.bounces = NO;
    [_tableView registerClass:[MySetTableViewCell class] forCellReuseIdentifier:@"MySetTableViewCell_Id"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MySetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MySetTableViewCell_Id"];
    if (!cell) {
        cell = [[MySetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MySetTableViewCell_Id"];
    }
    [cell drewContentViewWithIndexPathRRow:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ViewWidth(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        AboutAppViewController *vc = [[AboutAppViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
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
