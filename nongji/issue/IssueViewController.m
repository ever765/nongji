//
//  IssueViewController.m
//  nongji
//
//  Created by tobo on 17/3/27.
//  Copyright © 2017年 WDX. All rights reserved.
//发布

#import "IssueViewController.h"

@interface IssueViewController ()

@end

@implementation IssueViewController

- (void)viewDidLoad {
    self.vcTitle = @"发布订单";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = UIColorFromRGB(0xeeeeee);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createTableView{
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
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
