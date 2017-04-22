//
//  SetPasswordViewController.m
//  nongji
//
//  Created by tobo on 17/4/20.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "SetPasswordViewController.h"

#define SECTIONNUMBER 2
@interface SetPasswordViewController ()
{
    UITextField *_passwordTextField;
    UITextField *_passwordTTextField;
}
@end

@implementation SetPasswordViewController
- (NSString *)navigationTitleText{
    return @"设置密码";
}

- (CGFloat)tableViewBottomPadding{
    return ScreenHeight() - ViewWidth(88) * SECTIONNUMBER - 64;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNextButton];
    // Do any additional setup after loading the view.
}

#pragma mark ---- 设置密码
- (void)createNextButton{
    
    UIButton *setPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    setPasswordButton.frame = CGRectMake(ViewWidth(50) ,  ViewWidth(88) * SECTIONNUMBER + 64 + ViewWidth(80),ScreenWidth() - 2 * ViewWidth(50), ViewWidth(88));
    [setPasswordButton setTitle:@"设置密码" forState:UIControlStateNormal];
    setPasswordButton.backgroundColor = UIColorFromRGB(0x1784CA);
    [setPasswordButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    setPasswordButton.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 2];
    setPasswordButton.layer.cornerRadius = viewHeight(setPasswordButton)/2;
    setPasswordButton.layer.masksToBounds = YES;
    [setPasswordButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:setPasswordButton];
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
        _passwordTextField = textField;
        _passwordTextField.placeholder = @"请输入密码（6-16个字符）";
        _passwordTextField.frame = CGRectMake(0, 0, ScreenWidth(), ViewWidth(87));
    }
    if (indexPath.row ==1) {
        _passwordTTextField = textField;
        _passwordTTextField.placeholder = @"请输入确认密码（6-16个字符）";
        _passwordTTextField.frame = CGRectMake(0, 0, ScreenWidth(), ViewWidth(87));
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ViewWidth(88);
}
- (void)buttonAction:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
