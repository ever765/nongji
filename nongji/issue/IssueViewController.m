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
@property (nonatomic,strong)NSDictionary *dataSource;
@end

@implementation IssueViewController

- (NSString *)navigationTitleText{
    return @"发布";
}

- (CGFloat)tableViewBottomPadding{
    return ViewWidth(88);
}

- (UIImage *)navigationLeftImage{
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createButton];
    // Do any additional setup after loading the view.
}

- (void)initData{
    
    _cellTitleLableArray = @[@"必填项",@"姓名",@"联系电话",@"作业地点",@"详细地址",@"耕作面积",@"农作物",@"作业时间",@"服务类型",@"选填项",@"理想报价",@"描述"];
    _dataSource = [NSMutableDictionary new];
}

//订单确认
- (void)createButton{
    UIButton *issueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    issueButton.frame = CGRectMake(0 , ScreenHeight() - ViewWidth(88),ScreenWidth(), ViewWidth(88));
    [issueButton setTitle:@"发布" forState:UIControlStateNormal];
    issueButton.backgroundColor = UIColorFromRGB(0x1784CA);
    [issueButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    issueButton.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 2];
    [issueButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:issueButton];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _cellTitleLableArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 11) {
       return ScreenWidth()/2   + ViewWidth(88);
    }
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
    if (indexPath.row == 6) {
        NSArray *slectArray= @[@"小麦",@"玉米",@"水稻",@"其他"];
        SIActionSheet* actionSheet = [[SIActionSheet alloc] initWithCancelButonTitle:@"取消" otherButtonTitles:slectArray delegate:self];
        actionSheet.tag = 50+indexPath.row;
        actionSheet.delegate = self;
        [actionSheet show];
    }else if (indexPath.row == 8){
        NSArray *slectArray= @[@"水产运输",@"水稻运输"];
        SIActionSheet* actionSheet = [[SIActionSheet alloc] initWithCancelButonTitle:@"取消" otherButtonTitles:slectArray delegate:self];
        actionSheet.tag = 50+indexPath.row;
        actionSheet.delegate = self;
        [actionSheet show];
    }
}

- (void)addDateFromDict{
    NSArray *array = @[@"",@"contactName",@"contactPhone",@"place",@"address",@"area",@"crops",@"worktime",@"servetype",@"",@"farmerPrice",@"descs"];
    for (NSInteger i= 0; i < _cellTitleLableArray.count; i++) {
        
        if (i==0 || i== 9) {
            continue;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        IssueTableViewCell *cell = (IssueTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if (i == 11) {
              [_dataSource setValue:cell.textView.text forKey:array[i]];
            continue;
        }
  
        [_dataSource setValue:cell.textField.text forKey:array[i]];
    }
}



-(void)actionSheet:(SIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex withTitle:(NSString *)title{
    
    if (actionSheet.tag ==56 || actionSheet.tag ==58 ||actionSheet.tag ==59) {
        NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:actionSheet.tag-50 inSection:0];
        IssueTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.textField.text = title;
    }
    
}

- (void)buttonAction:(UIButton *)button{
    [self addDateFromDict];
    [_dataSource setValue:GETUSERID forKey:@"userId"];
    [API requestVerificationAFURL:[NSString stringWithFormat:@"%@farmer/order/create",NONGJIURL] httpMethod:METHOD_POST parameters:_dataSource Authorization:nil viewController:self succeed:^(id responseObject) {
        if (responseObject) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        
    }];
    NSLog(@"发布 %@",_dataSource);
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
