//
//  LoginViewController.m
//  nongji
//
//  Created by tobo on 17/4/20.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "AppDelegate.h"
#import "NJTabbarViewController.h"
#define ViewFrameOriginX ViewWidth(50)

@interface LoginViewController ()<UITextFieldDelegate,UIApplicationDelegate>
{
    UITextField *_phoneField;
    UITextField *_passwordField;
    UIButton *_loginButton;
}

@end

@implementation LoginViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.isHiddenNaVc = YES;
    [self createUI];
//    [self deleImage];
    // Do any additional setup after loading the view.
}
#pragma mark 右上角返回
//-(void)deleImage
//{
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.bounds=CGRectMake(0, 0, 40, 40);
//    btn.center=CGPointMake(ScreenWidth()-15-btn.bounds.size.width*0.5, 35+btn.bounds.size.height*0.5);
//    [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//}
//-(void)back
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)createUI{
#pragma mark ----logo  图片显示
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth() / 2 - ViewWidth(100), ScreenHeight() / 2 - ViewWidth(500), ViewWidth(200), ViewWidth(200))];
    imageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:imageView];

#pragma mark ---- 账号输入框
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(ViewFrameOriginX, MaxY(imageView) + ViewWidth(100), ScreenWidth() - ViewWidth(100), ViewWidth(80))];
    view1.backgroundColor = UIColorFromRGB(0xeeeeee);
    view1.layer.cornerRadius = viewHeight(view1)/2;
    view1.layer.masksToBounds = YES;
    [self.view addSubview:view1];
    
    _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(30), ViewWidth(20) , viewWidth(view1) - ViewWidth(60), ViewWidth(40))];
    _phoneField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_login"]];
    _phoneField.leftViewMode = UITextFieldViewModeAlways;
    _phoneField.clearButtonMode = UITextFieldViewModeAlways;
    [view1 addSubview:_phoneField];
    
#pragma mark ---- 密码输入框
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(ViewFrameOriginX, MaxY(view1) + ViewWidth(50), ScreenWidth() - ViewWidth(100), ViewWidth(80))];
    view2.backgroundColor = UIColorFromRGB(0xeeeeee);
    view2.layer.cornerRadius = viewHeight(view2)/2;
    view2.layer.masksToBounds = YES;
    [self.view addSubview:view2];
    
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(30), ViewWidth(20) , viewWidth(view1) - ViewWidth(60), ViewWidth(40))];
    _passwordField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_collection"]];
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    _passwordField.clearButtonMode = UITextFieldViewModeAlways;
    [view2 addSubview:_passwordField];
#pragma mark ---- 注册按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ViewFrameOriginX, MaxY(view2)+ViewWidth(30), ViewWidth(150), ViewWidth(30));
    [button setTitle:@"注册" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 2];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
    
#pragma mark ---- 忘记密码
    UIButton *forgetPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPassword.frame = CGRectMake(MaxX(view1) - ViewWidth(150), MaxY(view2) + ViewWidth(30), ViewWidth(150), ViewWidth(30));
    [forgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPassword setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    forgetPassword.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 2];
    [forgetPassword addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:forgetPassword];
    
#pragma mark ---- 登录
    UIButton *loginPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    loginPassword.frame = CGRectMake(ViewFrameOriginX , MaxY(forgetPassword) + ViewWidth(80),ScreenWidth() - 2 * ViewFrameOriginX, ViewWidth(88));
    [loginPassword setTitle:@"登录" forState:UIControlStateNormal];
    loginPassword.backgroundColor = UIColorFromRGB(0x1784CA);
    [loginPassword setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    loginPassword.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 2];
    loginPassword.layer.cornerRadius = viewHeight(loginPassword)/2;
    loginPassword.layer.masksToBounds = YES;
    [loginPassword addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:loginPassword];
}


- (void)buttonAction:(UIButton *)button{
    if ([button.currentTitle isEqualToString:@"登录"]) {
        AppDelegate *delegate = (id)[UIApplication sharedApplication].delegate;
        UIWindow *keyWindow=delegate.window;
        keyWindow.rootViewController = [[NJTabbarViewController alloc] init];
    }else if ([button.currentTitle isEqualToString:@"注册"]){
        RegisterViewController *vc = [[RegisterViewController  alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([button.currentTitle isEqualToString:@"忘记密码"]){
        ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc] init];
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
