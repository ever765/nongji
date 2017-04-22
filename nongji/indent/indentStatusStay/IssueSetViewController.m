//
//  IssueSetViewController.m
//  nongji
//
//  Created by tobo on 17/4/21.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "IssueSetViewController.h"
#import "IssueSetTableViewCell.h"
@interface IssueSetViewController ()

@end

@implementation IssueSetViewController

- (NSString *)navigationTitleText{
    return @"订单确认";
}

- (UIImage *)navigationRightImage{
    return [UIImage imageNamed:@"ic_action_collection"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerCellID];
    [self createButton];
}
//订单确认
- (void)createButton{
    UIButton *issueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    issueButton.frame = CGRectMake(0 , ScreenHeight() - ViewWidth(88),ScreenWidth(), ViewWidth(88));
    [issueButton setTitle:@"订单确认" forState:UIControlStateNormal];
    issueButton.backgroundColor = UIColorFromRGB(0x1784CA);
    [issueButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    issueButton.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 2];
    [issueButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:issueButton];
}

- (void)registerCellID{
    [self.tableView registerClass:[IssueSetTableViewCell class] forCellReuseIdentifier:@"IssueSetTableViewCell_Id"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IssueSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IssueSetTableViewCell_Id"];
    if (!cell) {
        cell = [[IssueSetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IssueSetTableViewCell_Id"];
    }
    [cell drewContentViewWithIndexPathRRow:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ViewWidth(88);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableViewBottomPadding{
    return ViewWidth(88);
}

- (void)navigationRightAction:(id)sender{
    NSLog(@"收藏成功");
}

- (void)buttonAction:(UIButton *)button{
    
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
