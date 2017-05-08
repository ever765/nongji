//
//  HomeViewController.m
//  nongji
//
//  Created by tobo on 17/4/24.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableHeaderView.h"
#import "HomeTableViewCell.h"
#import "HomeModel.h"
#import "NewsListViewController.h"
#import "MoreUserListConteoller.h"
#import "NewsDetialViewController.h"
#import "MachineDetialViewController.h"
#import <UIImageView+WebCache.h>
@interface HomeViewController ()
{
    HomeTableHeaderView *_headerView;
    HomeModel *_siliderModel;
    HomeModel *_aroundModel;
}
@end

@implementation HomeViewController

- (NSString *)navigationTitleText{
    return @"首页";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initData{
    [API requestVerificationAFURL:[NSString stringWithFormat:@"%@farmer/index?userId=%@",NONGJIURL,GETUSERID] httpMethod:METHOD_GET parameters:nil Authorization:nil viewController:self succeed:^(id responseObject) {
        if (responseObject) {
            _siliderModel = [[HomeModel alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"message"] error:nil];
            [_headerView setDataScoure:_siliderModel];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    
        [API requestVerificationAFURL:[NSString stringWithFormat:@"%@around?latitude=39.9&longitude=116.3&type=2&page=1&rows=5",NONGJIURL] httpMethod:METHOD_GET parameters:nil Authorization:nil viewController:self succeed:^(id responseObject) {
            if (responseObject) {
                _aroundModel = [[HomeModel alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"message"] error:nil];
                [self.tableView reloadData];
            }
        } failure:^(NSError *error) {
    
        }];
}
- (void)initView{
    [self createHeaderView];
}

- (void)createHeaderView{
    _headerView = [[HomeTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), ViewWidth(430))];
    
    self.tableView.tableHeaderView = _headerView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_siliderModel && section ==0) {
        return  _siliderModel.news.count;
    }else if (_aroundModel && section == 1){
        return _aroundModel.list.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"cellId%ld",indexPath.section];
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.model = _siliderModel.news[indexPath.row];
    }else if (indexPath.section == 1){
        cell.mode = _aroundModel.list[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
         return ViewWidth(88);
    }
    return ViewWidth(180);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), ViewWidth(20))];
    lineView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [view addSubview:lineView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:section == 0 ?@"lb_ic_img_hover":@"ic_action_recent"]];
    imageView.frame = CGRectMake(ViewWidth(50), MaxY(lineView) + ViewWidth(10), ViewWidth(50),section ==0?ViewWidth(40):ViewWidth(50));
    [view addSubview:imageView];
    
    UILabel *label = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText: section == 0?@"最新资讯":@"附近机手"];
    CGSize size = LabelSize(label.text, titleFontSize - 2);
    label.frame = CGRectMake(MaxX(imageView) + ViewWidth(30), 0, size.width , size.height);
    label.center = CGPointMake(label.center.x, imageView.center.y);
    [view addSubview:label];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"更多" forState:UIControlStateNormal];
    button.frame = CGRectMake(ScreenWidth() - ViewWidth(150), MaxY(lineView) + ViewWidth(10), ViewWidth(200), ViewWidth(40));
    [button setTitleColor:UIColorFromRGB(0x888888) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ic_action_jifen"] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, ViewWidth(95))];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, ViewWidth(95), 0, ViewWidth(0))];
    button.tag = section + 100;
    [view addSubview:button];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NewsDetialViewController *vc = [[NewsDetialViewController alloc] init];
        vc.model = _siliderModel.news[indexPath.row];
        PUSH
    }else if (indexPath.section == 1){
        MachineDetialViewController *vc = [[MachineDetialViewController alloc] init];
        vc.Id = [_aroundModel.list[indexPath.row] list_id];
        PUSH;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == self.tableView) {
        CGFloat sectionHeaderHeight = ViewWidth(88);
        if (scrollView.contentOffset.y==0) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ViewWidth(88);
}


- (void)buttonAction:(UIButton *)btn{
    if (btn.tag == 101) {
        MoreUserListConteoller *vc = [[MoreUserListConteoller alloc] init];
        PUSH;
    }else if (btn.tag == 100){
        NewsListViewController *vc = [[NewsListViewController alloc] init];
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
