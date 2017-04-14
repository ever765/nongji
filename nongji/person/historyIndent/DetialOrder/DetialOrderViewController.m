//
//  DetialOrderViewController.m
//  nongji
//
//  Created by Cus on 2017/4/14.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "DetialOrderViewController.h"
#import "DetialOrderTableViewCell.h"
@interface DetialOrderViewController ()

@end

@implementation DetialOrderViewController

- (void)viewDidLoad {
    self.vcTitle = @"订单详情";
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

-(void)registerCellID{
    _tableView.frame = CGRectMake(0, ViewWidth(100) + 64, ScreenWidth(), ScreenHeight() - 64 - ViewWidth(100));
    //    _tableView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [_tableView registerClass:[DetialOrderTableViewCell class] forCellReuseIdentifier:@"DetialOrderTableViewCell_ID"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetialOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetialOrderTableViewCell_ID"];
    if (!cell) {
        cell = [[DetialOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DetialOrderTableViewCell_ID"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
