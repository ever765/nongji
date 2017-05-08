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
#import "MySetViewController.h"
#import "HistoricalOrderViewController.h"
#import <UIImageView+WebCache.h>
#import "AutonymViewController.h"
@interface PersonViewController ()
{
    UIImageView *_headerView;//tableview的headerView
    UIImageView *_imageView;//头像
    UILabel *_phoneLabel;//电话号码
    UILabel *_statusLable;//是否实名认证;
    NSDictionary *_dataSource;
}
@end

@implementation PersonViewController

- (NSString *)navigationTitleText{
    return @"个人中心";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellID];
    [self initData];
    [self createHeaderView];
    // Do any additional setup after loading the view.
}

- (void)initData{
    [API requestVerificationAFURL:[NSString stringWithFormat:@"%@user/info?userId=%@",NONGJIURL,GETUSERID] httpMethod:METHOD_GET parameters:nil Authorization:nil viewController:self succeed:^(id responseObject) {
        if (responseObject) {
            _dataSource = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@dl?path=%@",NONGJIURL,_dataSource[@"message"][@"user"][@"headimage"]]]];
            _phoneLabel.text = _dataSource[@"message"][@"user"][@"loginName"];
            NSString *str;
            switch ([_dataSource[@"message"][@"user"][@"userstate"] integerValue]) {
                case 0:
                    str = @"未认证";
                    break;
                case 1:
                    str = @"审核中";
                    break;
                case 9:
                    str = @"已认证";
                    break;
                default:
                    str = @"未认证";
                    break;
            }
            _statusLable.text = str;
        }
    } failure:^(NSError *error) {
    
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}
- (void)createHeaderView{
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), ViewWidth(256))];
    _headerView.image = [UIImage imageNamed:@"1"];
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
    self.tableView.tableHeaderView = _headerView;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = UIColorFromRGB(0xeeeeee);
}

- (void)registerCellID{
    [self.tableView registerClass:[PersonTableViewCell class] forCellReuseIdentifier:@"PersonTableViewCell_Id"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 3;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonTableViewCell_Id"];
    if (!cell) {
        cell = [[PersonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonTableViewCell_Id"];
    }
    [cell drewContentViewWithIndexPathRRow:indexPath.row andsection:indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ViewWidth(88);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColorFromRGB(0xeeeeee);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ViewWidth(20);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0 && _dataSource) {
        InformationViewController *vc = [[InformationViewController alloc] init];
        vc.dataSource = _dataSource;
        PUSH;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        AutonymViewController *vc = [[AutonymViewController alloc] init];
        PUSH;
    }else if (indexPath.row == 2 && indexPath.section == 2){
        MySetViewController *vc = [[MySetViewController alloc] init];
        PUSH;
    }else if (indexPath.row == 1 && indexPath.section == 2){
        HistoricalOrderViewController *vc = [[HistoricalOrderViewController alloc] init];
        PUSH;
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
