//
//  InformationViewController.m
//  nongji
//
//  Created by Cus on 2017/4/19.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationTableViewCell.h"
#import "ChangePhoneController.h"
#import "SIActionSheet.h"
#import "AFNetworking.h"
#import "Photographs.h"
@interface InformationViewController ()<SIActionSheetDelegate>
{
    NSArray *_cellTitleLableArray;
    NSArray *_cellTextPlaceOrderArray; ///< tableView后面的标题
    UIDatePicker *_datepicker;
    UIPickerView *_picker;
    UIView *_NJMBView;//蒙版
    NSData *_data;
    NSMutableDictionary *_submitDataSource;
    Photographs *_photo;
}

@end

@implementation InformationViewController
- (NSString *)navigationTitleText{
    return @"个人资料";
}

- (CGFloat)tableViewBottomPadding{
    return ScreenHeight() - 64 - ViewWidth(120) - ViewWidth(88) * 6;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createButton];
    _cellTitleLableArray = @[@"头像",@"姓名",@"性别",@"出生日期",@"电话"];
    _submitDataSource = [NSMutableDictionary new];
    self.tableView.bounces = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//提交
- (void)createButton{
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(ViewWidth(50),   64 + ViewWidth(120) + ViewWidth(88) * 6,ScreenWidth() - ViewWidth(100), ViewWidth(88));
     submit.layer.masksToBounds = YES;
    submit.layer.cornerRadius = ViewWidth(44);
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    submit.backgroundColor = UIColorFromRGB(0x1784CA);
    [submit setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    submit.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 2];
    [submit addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:submit];
}

- (void)setDataSource:(NSDictionary *)dataSource{
    _dataSource = dataSource;
    _cellTextPlaceOrderArray = @[_dataSource[@"message"][@"user"][@"headimage"],_dataSource[@"message"][@"user"][@"realName"],_dataSource[@"message"][@"user"][@"gender"],_dataSource[@"message"][@"user"][@"birthday"],_dataSource[@"message"][@"user"][@"loginName"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellTitleLableArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellid = [NSString stringWithFormat:@"cellID%ld", indexPath.row];
    InformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        
        cell = [[InformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        [cell addSubviewsWithindexRow:indexPath];
        [cell configureData:_cellTitleLableArray :_cellTextPlaceOrderArray indexRow:indexPath.row];
       
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return ViewWidth(120);
    }
    return ViewWidth(88);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
            NSArray *slectArray= @[@"男",@"女"];
            SIActionSheet* actionSheet = [[SIActionSheet alloc] initWithCancelButonTitle:@"取消" otherButtonTitles:slectArray delegate:self];
            actionSheet.tag = 50+indexPath.row;
            actionSheet.delegate = self;
            [actionSheet show];
    }else if (indexPath.row == 3){
        [self creatMengbanview];
    }else if (indexPath.row == 0){
        _photo = [[Photographs alloc] init];
        InformationTableViewCell *cell = (InformationTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [_photo changeAvatar:cell.headerImageView withViewController:self withUrl:nil];
    }
}



- (void)addDateFromDict{
    NSArray *array = @[@"",@"realName",@"gender",@"birthday",@"loginName"];
    for (NSInteger i= 0; i < _cellTitleLableArray.count; i++) {
        if (i==0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            InformationTableViewCell *cell = (InformationTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            _data = [MyTools getImageCompress:cell.headerImageView.image];
            continue;
        }else if (i == _cellTitleLableArray.count - 1){
            continue;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        InformationTableViewCell *cell = (InformationTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [_submitDataSource setValue:cell.textField.text forKey:array[i]];
    }
    [_submitDataSource setValue:GETUSERID forKey:@"id"];
}

-(void)actionSheet:(SIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex withTitle:(NSString *)title{
    
    if (actionSheet.tag ==52) {
        NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:actionSheet.tag-50 inSection:0];
        InformationTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.textField.text = title;
    }
    
}

- (void)buttonAction:(UIButton *)button{
    [self addDateFromDict];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    [manager POST:[NSString stringWithFormat:@"%@user/update",NONGJIURL] parameters:_submitDataSource constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (_data) {
            [formData appendPartWithFileData:_data name:@"file" fileName:[NSString stringWithFormat:@"image[%d].png",1] mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"OK"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
          [self showHint:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self showHint:@"请求失败"];
        
    }];
}

-(void)creatMengbanview
{
    if (!_NJMBView) {
         _NJMBView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth(), ScreenHeight())];
        
        _NJMBView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        
        UIView *superView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight()-ScreenWidth()+30, ScreenWidth(), ScreenWidth()-30)];
        superView.backgroundColor=[UIColor whiteColor];
        [_NJMBView addSubview:superView];
        
        
        UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn setTitleColor:UIColorFromRGB(0x1d8fe1) forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:leftBtn];
        UIView *grayline=[[UIView alloc]initWithFrame:CGRectMake(0, leftBtn.bounds.size.height-1, ScreenWidth(), 1)];
        grayline.backgroundColor=mainBlackgroundColor;
        [leftBtn addSubview:grayline];
        
        
        UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth()-70, 0, 70, 40)];
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn setTitleColor:UIColorFromRGB(0x1d8fe1) forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:rightBtn];
        leftBtn.tag=100;
        rightBtn.tag=200;
        _datepicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(leftBtn.frame), ScreenWidth(),superView.bounds.size.height-CGRectGetMaxY(leftBtn.frame))];
        _datepicker.datePickerMode=UIDatePickerModeDate;
        [superView addSubview:_datepicker];
        
        NSString *minStr = @"1900-01-01";
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *minDate = [dateFormatter dateFromString:minStr];
        _datepicker.minimumDate = minDate;
        _datepicker.maximumDate=[NSDate date];

    }
   
    [self.view addSubview:_NJMBView];
    
    
}
-(void)btnClick:(UIButton *)btn
{
    if (btn.tag==200) {
       [self datepick];
    }
    [_NJMBView removeFromSuperview];
    _NJMBView=nil;
}

#pragma mark 确定日期
-(void)datepick
{
    NSDate *date=[_datepicker date];
    NSDateFormatter *fomatter=[[NSDateFormatter alloc]init];
    fomatter.dateFormat=@"yyyy-MM-dd";
    NSString *dateStr=[fomatter stringFromDate:date];
    
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:3 inSection:0];
    InformationTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textField.text = dateStr;

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
