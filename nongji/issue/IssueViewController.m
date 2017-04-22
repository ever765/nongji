//
//  IssueViewController.m
//  nongji
//
//  Created by Cus on 2017/4/19.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "IssueViewController.h"
#import "IssueTableViewCell.h"
#import "SIActionSheet.h"
@interface IssueViewController ()<SIActionSheetDelegate>
@property (nonatomic,strong)NSArray *cellTitleLableArray;    ///< tableView前面的标题
@property (nonatomic,strong)NSArray *cellTextPlaceOrderArray; ///< tableView后面的标题
@end

@implementation IssueViewController

- (NSString *)navigationTitleText{
    return @"发布";
}

- (UIImage *)navigationLeftImage{
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)initData{
    
    _cellTitleLableArray = @[@"必填项",@"作业地点",@"详细地址",@"耕作面积",@"农作物",@"作业时间",@"服务类型",@"选填项",@"理想报价",@"描述"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _cellTitleLableArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   return ViewWidth(88);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellid = [NSString stringWithFormat:@"cellID%ld", indexPath.row];
    IssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[IssueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        [cell addSubviewsWithindexRow:indexPath.row];
        [cell configureData:_cellTitleLableArray :_cellTextPlaceOrderArray indexRow:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        NSArray *slectArray= @[@"小麦",@"玉米",@"水稻",@"其他"];
        SIActionSheet* actionSheet = [[SIActionSheet alloc] initWithCancelButonTitle:@"取消" otherButtonTitles:slectArray delegate:self];
        actionSheet.tag = 50+indexPath.row;
        actionSheet.delegate = self;
        [actionSheet show];
    }else if (indexPath.row == 6){
        NSArray *slectArray= @[@"水产运输",@"水稻运输"];
        SIActionSheet* actionSheet = [[SIActionSheet alloc] initWithCancelButonTitle:@"取消" otherButtonTitles:slectArray delegate:self];
        actionSheet.tag = 50+indexPath.row;
        actionSheet.delegate = self;
        [actionSheet show];
    }
    
}



-(void)actionSheet:(SIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex withTitle:(NSString *)title{
    
    if (actionSheet.tag ==54 || actionSheet.tag ==56 ||actionSheet.tag ==57) {
        NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:actionSheet.tag-50 inSection:0];
        IssueTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.textField.text = title;
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
