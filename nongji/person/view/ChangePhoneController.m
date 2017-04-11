//
//  ChangePhoneController.m
//  nongji
//
//  Created by tobo on 17/4/9.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "ChangePhoneController.h"
#import "NsTime.h"
#import "ChangePasswordViewController.h"
#define ViewFrameOriginX ViewWidth(88)
@interface ChangePhoneController ()
{
    UITextField *_phoneTextField;//手机号码
    UITextField *_identifyingCodeTextField;//验证码
    UIButton *_identifyingCodeButton;
    NsTime *_timer;//倒计时
}
@end

@implementation ChangePhoneController

- (void)viewDidLoad {
    self.vcTitle = @"更改手机号";
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}
- (void)createTableView{
    
}
- (void)initView{
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewFrameOriginX, ViewWidth(300), ViewWidth(70), ViewWidth(70))];
    imageView.image = [UIImage imageNamed:@"ic_action_collection"];
    [self.view addSubview:imageView];
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(MaxX(imageView)+ViewWidth(20), MinY(imageView), ScreenWidth() - MaxX(imageView) * 2, viewHeight(imageView))];
    _phoneTextField.backgroundColor = UIColorFromRGB(0xffffff);
    _phoneTextField.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
    _phoneTextField.layer.borderWidth = ViewWidth(1);
    _phoneTextField.placeholder = @"输入11位手机号";
    [self.view addSubview:_phoneTextField];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewFrameOriginX, MaxY(imageView)+ViewWidth(20), ViewWidth(70), ViewWidth(70))];
    imageView1.image = [UIImage imageNamed:@"ic_action_collection"];
    [self.view addSubview:imageView1];
    CGSize size = LabelSize(@"888888888", titleFontSize);
    _identifyingCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(MaxX(imageView1)+ViewWidth(20), MinY(imageView1),size.width , viewHeight(imageView1))];
    _identifyingCodeTextField.placeholder = @"验证码";
    _identifyingCodeTextField.backgroundColor = UIColorFromRGB(0xfffffff);
    _identifyingCodeTextField.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
    _identifyingCodeTextField.layer.borderWidth = ViewWidth(1);
    [self.view addSubview:_identifyingCodeTextField];
    
    size = LabelSize(@"88s重新获取", titleFontSize);
    _identifyingCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_identifyingCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_identifyingCodeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    _identifyingCodeButton.frame = CGRectMake(MaxX(_phoneTextField) - size.width - ViewWidth(20), MinY(_identifyingCodeTextField), size.width+ViewWidth(20), viewHeight(_identifyingCodeTextField));
    [_identifyingCodeButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [self setLayerWidthWithButton:_identifyingCodeButton];
    [self.view addSubview:_identifyingCodeButton];
    _timer = [[NsTime alloc] init];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(ViewFrameOriginX, MaxY(_identifyingCodeButton) +ViewWidth(30), ScreenWidth() - 2 * ViewFrameOriginX, ViewWidth(70));
    [nextButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self setLayerWidthWithButton:nextButton];
    [nextButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [self.view addSubview:nextButton];
}

- (void)buttonAction:(UIButton *)button{
    if ([button isEqual:_identifyingCodeButton]) {
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
    }else{
        ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)setLayerWidthWithButton:(UIButton *)button{
    button.layer.borderWidth = ViewWidth(1);
    button.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
}

-(void)refreshUISecond:(NSInteger)second{
    NSString *str;
    if (second<10) {
        str = [NSString stringWithFormat:@"0%lds重新获取",(long)second];
    }else{
        str = [NSString stringWithFormat:@"%lds重新获取",(long)second];
    }
   
    [_identifyingCodeButton setTitle:str forState:UIControlStateNormal];
    
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
