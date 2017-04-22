//
//  RegisterViewController.m
//  nongji
//
//  Created by tobo on 17/4/20.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "RegisterViewController.h"
#import "NsTime.h"
#define SECTIONNUMBER 5
@interface RegisterViewController ()
{
    UITextField *_phoneTextField;
    UITextField *_verificationTextField;
    UITextField *_passwordTextField;
    UITextField *_passwordTTextField;
    
    UIButton *_verificationButton;
    UIButton *_agreeButton;
    UILabel *_agreeLabel;
    
    
    BOOL _isAgree;
    NsTime *_timer;//倒计时
    
}
@end

@implementation RegisterViewController

- (NSString *)navigationTitleText{
    return @"注册";
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
#pragma mark ---- 注册
- (void)createNextButton{
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(ViewWidth(50) ,  ViewWidth(88) * SECTIONNUMBER + 64 + ViewWidth(80),ScreenWidth() - 2 * ViewWidth(50), ViewWidth(88));
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.backgroundColor = UIColorFromRGB(0x1784CA);
    [registerButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 2];
    registerButton.layer.cornerRadius = viewHeight(registerButton)/2;
    registerButton.layer.masksToBounds = YES;
    [registerButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:registerButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (indexPath.row ==2) {
        _passwordTextField = textField;
        _passwordTextField.placeholder = @"请输入密码（6-16个字符）";
        _passwordTextField.frame = CGRectMake(0, 0, ScreenWidth(), ViewWidth(87));
    }
    if (indexPath.row ==3) {
        _passwordTTextField = textField;
        _passwordTTextField.placeholder = @"请输入确认密码（6-16个字符）";
        _passwordTTextField.frame = CGRectMake(0, 0, ScreenWidth(), ViewWidth(87));
    }
    if (indexPath.row ==4) {
        _agreeButton = button;
        _agreeButton.frame = CGRectMake(ViewWidth(30), ViewWidth(32), ViewWidth(26), ViewWidth(26));
        _agreeButton.layer.borderWidth = 1;
        [_agreeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
        _agreeButton.layer.borderColor = UIColorFromRGB(0x888888).CGColor;
        
        _agreeLabel = label;
        _agreeLabel.frame = CGRectMake(MaxX(_agreeButton) + ViewWidth(20), 0, ScreenWidth() - MaxX(_agreeButton) -ViewWidth(20), ViewWidth(87));
        _agreeLabel.text = @"注册协议《三五斗用户协议》";
        // 创建Attributed
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:_agreeLabel.text];
        // 需要改变的第一个文字的位置
        NSUInteger firstLoc = [[noteStr string] rangeOfString:@"议"].location + 1;
        // 需要改变的区间
        NSRange range = NSMakeRange(firstLoc,_agreeLabel.text.length - firstLoc);
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x1784CA) range:range];
        // 为label添加Attributed
        [_agreeLabel setAttributedText:noteStr];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(agreementDetail)];
        _agreeLabel.userInteractionEnabled=YES;
        [_agreeLabel addGestureRecognizer:tap];

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
    }else if ([button isEqual:_agreeButton]){
        static BOOL isback = NO;
        if (isback) {
            _isAgree = NO;
            _agreeButton.backgroundColor = UIColorFromRGB(0xffffff);
        }else{
            _isAgree = YES;
            _agreeButton.backgroundColor = UIColorFromRGB(0x1784CA);
        }
        isback = !isback;
    }else if ([button.currentTitle isEqualToString:@"注册"]){
        [self.navigationController popToRootViewControllerAnimated:YES];
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

#pragma mark ---- 跳转协议详情
- (void)agreementDetail{
    NSLog(@"跳转协议详情");
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
