//
//  ChangePasswordViewController.m
//  nongji
//
//  Created by Cus on 2017/4/11.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "ChangePasswordViewController.h"
#define ViewFrameOriginX ViewWidth(88)
@interface ChangePasswordViewController ()
{
    UITextField *_passwordTextField;//密码
    UITextField *_confirmPasseordTextField;//确认密码
  
}
@end

@implementation ChangePasswordViewController
- (NSString *)navigationTitleText{
    return @"修改密码";
}
- (void)viewDidLoad {
    [super viewDidLoad];
     
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView{
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewFrameOriginX, ViewWidth(300), ViewWidth(70), ViewWidth(70))];
    imageView.image = [UIImage imageNamed:@"ic_action_collection"];
    [self.view addSubview:imageView];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(MaxX(imageView)+ViewWidth(20), MinY(imageView), ScreenWidth() - MaxX(imageView) * 2, viewHeight(imageView))];
    _passwordTextField.backgroundColor = UIColorFromRGB(0xffffff);
    _passwordTextField.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
    _passwordTextField.layer.borderWidth = ViewWidth(1);
    _passwordTextField.placeholder = @"请输入密码";
    [self.view addSubview:_passwordTextField];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewFrameOriginX, MaxY(imageView)+ViewWidth(20), ViewWidth(70), ViewWidth(70))];
    imageView1.image = [UIImage imageNamed:@"ic_action_collection"];
    [self.view addSubview:imageView1];
    _confirmPasseordTextField = [[UITextField alloc] initWithFrame:CGRectMake(MaxX(imageView1)+ViewWidth(20), MinY(imageView1),viewWidth(_passwordTextField) , viewHeight(imageView1))];
    _confirmPasseordTextField.placeholder = @"请再次确认密码";
    _confirmPasseordTextField.backgroundColor = UIColorFromRGB(0xfffffff);
    _confirmPasseordTextField.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
    _confirmPasseordTextField.layer.borderWidth = ViewWidth(1);
    [self.view addSubview:_confirmPasseordTextField];
    
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(ViewFrameOriginX, MaxY(_confirmPasseordTextField) +ViewWidth(30), ScreenWidth() - 2 * ViewFrameOriginX, ViewWidth(70));
    [nextButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self setLayerWidthWithButton:nextButton];
    [nextButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [self.view addSubview:nextButton];
}

- (void)buttonAction:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)setLayerWidthWithButton:(UIButton *)button{
    button.layer.borderWidth = ViewWidth(1);
    button.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
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
