//
//  IndentFinishViewController.m
//  nongji
//
//  Created by tobo on 17/4/21.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "IndentFinishViewController.h"
#import "IndentFinishTableViewCell.h"
#import "EvaluateViewController.h"
@interface IndentFinishViewController ()

@end

@implementation IndentFinishViewController

- (NSString *)navigationTitleText{
    return @"订单详情";
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
    [issueButton setTitle:@"评价机手" forState:UIControlStateNormal];
    issueButton.backgroundColor = UIColorFromRGB(0x1784CA);
    [issueButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    issueButton.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 2];
    [issueButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:issueButton];
}

- (void)registerCellID{
    [self.tableView registerClass:[IndentFinishTableViewCell class] forCellReuseIdentifier:@"IndentFinishTableViewCell_Id"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndentFinishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndentFinishTableViewCell_Id"];
    if (!cell) {
        cell = [[IndentFinishTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndentFinishTableViewCell_Id"];
    }
    [cell drewContentViewWithIndexPathRRow:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ViewWidth(88);
}

- (void)buttonAction:(UIButton *)button{
    EvaluateViewController *vc = [[EvaluateViewController alloc] init];
    PUSH
}

- (CGFloat)tableViewBottomPadding{
    return ViewWidth(88);
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
