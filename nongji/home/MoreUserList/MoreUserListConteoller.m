//
//  MoreUserListConteoller.m
//  nongji
//
//  Created by Cus on 2017/4/19.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "MoreUserListConteoller.h"
#import "MoreUserListModel.h"
#import "MoreUserListTableCell.h"
#import "MachineDetialViewController.h"
@interface MoreUserListConteoller ()
{
    MoreUserListModel *_aroundModel;
    NSMutableArray *_dataSource;
    NSInteger _pages;
}
@end

@implementation MoreUserListConteoller

-(NSString *)navigationTitleText{
    return @"附近机手";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)initData{
    _dataSource = [[NSMutableArray alloc] init];
    self.supportPullUpRefresh = YES;
    self.supportPullDownRefresh = YES;
    [self pullDownRefreshData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   if (_aroundModel){
        return _dataSource.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"cellId%@",@1];
    MoreUserListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MoreUserListTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.mode = _dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- 设置tableview
- (void)pullDownRefreshData{
    [_dataSource removeAllObjects];
    _pages = 1;
    NSString   *url = [NSString stringWithFormat:@"%@around?latitude=39.9&longitude=116.3&type=2&page=1&rows=20",NONGJIURL];
    [API requestVerificationAFURL:url httpMethod:METHOD_GET parameters:nil Authorization:nil viewController:self succeed:^(id responseObject) {
        if (responseObject) {
            _aroundModel = [[MoreUserListModel alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"message"] error:nil];
            for (ListModel *mod in _aroundModel.list) {
                [_dataSource addObject:mod];
            }
            [self.tableView reloadData];
        }
        [self finishPullDownRefresh:YES];
    } failure:^(NSError *error) {
        [self finishPullDownRefresh:YES];
    }];
    
    
}

- (void)pullUpRefreshData{
    NSString *url;
    _pages++;
    url = [NSString stringWithFormat:@"%@news?type=2&page=%ld&rows=20",NONGJIURL,_pages];
    [API requestVerificationAFURL:url httpMethod:METHOD_GET parameters:nil Authorization:nil viewController:self succeed:^(id responseObject) {
        if (responseObject) {
            _aroundModel = [[MoreUserListModel alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][@"message"] error:nil];
            for (ListModel *mod in _aroundModel.list) {
                [_dataSource addObject:mod];
            }
            [self.tableView reloadData];
        }
        [self finishPullUpRefresh:YES hasMore:YES];
    } failure:^(NSError *error) {
        [self finishPullUpRefresh:YES hasMore:YES];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MachineDetialViewController *vc = [[MachineDetialViewController alloc] init];
    vc.Id = [_dataSource[indexPath.row] list_id];
    PUSH;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ViewWidth(180);
}

- (void)finishPullDownRefresh:(BOOL)succeed{
    [super finishPullDownRefresh:succeed];
}

- (void)finishPullUpRefresh:(BOOL)succeed hasMore:(BOOL)hasMore{
    [super finishPullUpRefresh:succeed hasMore:hasMore];
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
