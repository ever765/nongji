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
}
@end

@implementation HistoricalOrderViewController

- (void)viewDidLoad {
    self.vcTitle = @"历史订单";
    [super viewDidLoad];
    [self createHeaderView];
    [self registerCellID];
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
    [allButton setTitleColor:UIColorFromRGB(0xeeeeee) forState:UIControlStateNormal];
    _lastButton = allButton;
    _lastButton.selected = YES;
    
    CustomButton *abnormalButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    abnormalButton.frame = CGRectMake(ScreenWidth()/2 +ViewFrameOriginX /2 , 0, ScreenWidth()/2  - ViewFrameOriginX *1.5, ViewWidth(78));
    [abnormalButton setTitle:@"异常订单" forState:UIControlStateNormal];
    [abnormalButton setTitleColor:UIColorFromRGB(0xeeeeee) forState:UIControlStateNormal];
    [abnormalButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [headerView addSubview:abnormalButton];
    [self.view addSubview:headerView];
}

-(void)registerCellID{
    _tableView.frame = CGRectMake(0, ViewWidth(100) + 64, ScreenWidth(), ScreenHeight() - 64 - ViewWidth(100));
//    _tableView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [_tableView registerClass:[HistoricalOrderTableViewCell class] forCellReuseIdentifier:@"HistoricalOrderTableViewCell_ID"];
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
