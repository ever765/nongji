//
//  ForgetPasswordViewController.m
//  nongji
//
//  Created by tobo on 17/4/20.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "SetPasswordViewController.h"
#import "NsTime.h"

#define SECTIONNUMBER 2
@interface ForgetPasswordViewController ()
{
    UITextField *_phoneTextField;
    UITextField *_verificationTextField;
    UIButton *_verificationButton;
    
     NsTime *_timer;//倒计时
}
@end

@implementation ForgetPasswordViewController

- (NSString *)navigationTitleText{
    return @"忘记密码";
}

- (CGFloat)tableViewBottomPadding{
    return ScreenHeight() - ViewWidth(88) * SECTIONNUMBER - 64;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNextButton];
    self.tableView.bounces = NO;
    // Do any additional setup after loading the view.
}

#pragma mark ---- 忘记密码
- (void)createNextButton{
    
    UIButton *ForgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ForgetPasswordButton.frame = CGRectMake(ViewWidth(50) ,  ViewWidth(88) * SECTIONNUMBER + 64 + ViewWidth(80),ScreenWidth() - 2 * ViewWidth(50), ViewWidth(88));
    [ForgetPasswordButton setTitle:@"下一步" forState:UIControlStateNormal];
    ForgetPasswordButton.backgroundColor = UIColorFromRGB(0x1784CA);
    [ForgetPasswordButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    ForgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 2];
    ForgetPasswordButton.layer.cornerRadius = viewHeight(ForgetPasswordButton)/2;
    ForgetPasswordButton.layer.masksToBounds = YES;
    [ForgetPasswordButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:ForgetPasswordButton];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return SECTIONNUMBER;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    UITextField *textField;
    UILabel *label;
    UIButton *button;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellId"];
        textField = [[UITextField alloc] init];
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.font = [UIFont systemFontOfSize:titleFontSize - 2];
        [cell.contentView addSubview:textField];
        label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:titleFontSize - 4];
        [cell.contentView addSubview:label];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [cell.contentView addSubview:button];
        UIView *downLineview = [[UIView alloc] initWithFrame:CGRectMake(0, ViewWidth(87), ScreenWidth(), ViewWidth(1))];
        downLineview.backgroundColor = UIColorFromRGB(0xeeeeee);
        [cell.contentView addSubview:downLineview];
    }
    if (indexPath.row ==0) {
        _phoneTextField = textField;
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.frame = CGRectMake(0, 0, ScreenWidth(), ViewWidth(87));
    }
    if (indexPath.row ==1) {
        _verificationTextField = textField;
        _verificationTextField.placeholder = @"请输入短信验证码";
        _verificationButton = button;
        
        CGSize size = LabelSize(@"88s重新获取", titleFontSize - 4);
        _verificationButton.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 4];
        [_verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verificationButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
        _verificationButton.frame = CGRectMake(ScreenWidth() - ViewWidth(50) - size.width - ViewWidth(40), ViewWidth(19), size.width+ViewWidth(20), ViewWidth(50));
        _verificationButton.backgroundColor = UIColorFromRGB(0x1784CA);
        _verificationButton.layer.cornerRadius = viewHeight(_verificationButton)/2;
        _verificationButton.layer.masksToBounds = YES;
        [_verificationButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        _timer = [[NsTime alloc] init];
        
        _verificationTextField.frame = CGRectMake(0, 0, MinX(_verificationButton) - ViewWidth(20), ViewWidth(87));
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ViewWidth(88);
}
- (void)buttonAction:(UIButton *)button{
    if ([button isEqual:_verificationButton]) {
        button.userInteractionEnabled = NO;
        // 当前时间值，GMT 时间
        NSDate *now = [[NSDate alloc] init];
        // 当前时间加 n 秒后的值
        NSDate *endDate = [[NSDate alloc] initWithTimeIntervalSinceNow:59];
        __weak __typeof(self) weakSelf= self;
        [_timer countDownWithStratDate:now finishDate:endDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
            if (second == 0) {
                button.userInteractionEnabled = YES;
            }
            [weakSelf refreshUISecond:second];
        }];
    }else if ([button.currentTitle isEqualToString:@"下一步"]){
        
        if ([NSString stringIsLoginUser:_phoneTextField.text withViewController:self]) {
            return;
        }
        if ([NSString stringPayPassword:_verificationTextField.text withViewController:self]) {
            return;
        }
        SetPasswordViewController *vc = [[SetPasswordViewController alloc] init];
        vc.longinName = _phoneTextField.text;
        PUSH;
    }
    
}
-(void)refreshUISecond:(NSInteger)second{
    NSString *str;
    if (second<10) {
        str = [NSString stringWithFormat:@"0%lds重新获取",(long)second];
    }else{
        str = [NSString stringWithFormat:@"%lds重新获取",(long)second];
    }
    [_verificationButton setTitle:str forState:UIControlStateNormal];
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
