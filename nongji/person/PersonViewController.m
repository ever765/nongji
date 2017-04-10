//
//  PersonViewController.m
//  nongji
//
//  Created by tobo on 17/3/27.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonTableViewCell.h"
#import "InformationViewController.h"
@interface PersonViewController ()
{
    UIView *_headerView;//tableview的headerView
    UIImageView *_imageView;//头像
    UILabel *_phoneLabel;//电话号码
    UILabel *_statusLable;//是否实名认证;
}
@end

@implementation PersonViewController

- (void)viewDidLoad {
    self.vcTitle = @"个人中心";
    self.isBack = NO;
    [super viewDidLoad];
    [self registerCellID];
    [self creaateHeaderView];
    // Do any additional setup after loading the view.
}

- (void)creaateHeaderView{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), ViewWidth(256))];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(88), ViewWidth(58), ViewWidth(140), ViewWidth(140))];
    _imageView.image = [UIImage imageNamed:@"ic_action_integral"];
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = ViewWidth(70);
    [_headerView addSubview:_imageView];
    
    _phoneLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@"18888888888"];
    CGSize size = LabelSize(_phoneLabel.text, titleFontSize);
    _phoneLabel.frame = CGRectMake(MaxX(_imageView) + ViewWidth(20), _imageView.center.y - ViewWidth(10) - size.height, size.width, size.height);
    [_headerView addSubview:_phoneLabel];
    
    _statusLable =[MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@"已实名认证"];
     size = LabelSize(_statusLable.text, titleFontSize);
    _statusLable.frame = CGRectMake(MaxX(_imageView) + ViewWidth(20), _imageView.center.y + ViewWidth(10), size.width, size.height);
    [_headerView addSubview:_statusLable];
    _tableView.tableHeaderView = _headerView;
}

- (void)registerCellID{
    [_tableView registerClass:[PersonTableViewCell class] forCellReuseIdentifier:@"PersonTableViewCell_Id"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonTableViewCell_Id"];
    if (!cell) {
        cell = [[PersonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonTableViewCell_Id"];
    }
    [cell drewContentViewWithIndexPathRRow:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ViewWidth(150);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        InformationViewController *vc = [[InformationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
