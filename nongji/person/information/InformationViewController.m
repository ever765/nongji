//
//  InformationViewController.m
//  nongji
//
//  Created by Cus on 2017/4/19.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationTableViewCell.h"
#import "ChangePhoneController.h"

@interface InformationViewController ()

@end

@implementation InformationViewController
- (NSString *)navigationTitleText{
    return @"个人资料";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellID];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)registerCellID{
    [self.tableView registerClass:[InformationTableViewCell class] forCellReuseIdentifier:@"InformationTableViewCell_Id"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InformationTableViewCell_Id"];
    if (!cell) {
        cell = [[InformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InformationTableViewCell_Id"];
    }
    [cell drewContentViewWithIndexPathRRow:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return ViewWidth(200);
    }else if (indexPath.row ==4){
        return ViewWidth(500);
    }
    return ViewWidth(88);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        ChangePhoneController  *vc = [[ChangePhoneController alloc] init];
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
