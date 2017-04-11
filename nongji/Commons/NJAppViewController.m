//
//  NJAppViewController.m
//  nongji
//
//  Created by tobo on 17/3/27.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "NJAppViewController.h"

@interface NJAppViewController ()
{
    UILabel *titleLable;
    
}
@end

@implementation NJAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//如果设置里。title。 表示有导航如果没有设置表示不需要导航
- (void)setVcTitle:(NSString *)vcTitle{
    _nvView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), 64)];
    _nvView.backgroundColor = UIColorFromRGB(0x888888);
    //  根据内容和字体大小。结算label的宽高。
    CGSize size = LabelSize(vcTitle, MainFontSize);
    _titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, size.width, size.height)];
    _titileLabel.textColor = UIColorFromRGB(0x333333);
    _titileLabel.center = CGPointMake(self.view.center.x, 42);
    _titileLabel.text = vcTitle;
    [_nvView addSubview:_titileLabel];
    UIImage *image=[UIImage imageNamed:@"left"];
    _backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:image forState:UIControlStateNormal];
    _backButton.bounds=CGRectMake(0, 0, 50, 100);
    _backButton.center=CGPointMake(_backButton.bounds.size.width*0.5, _titileLabel.center.y);
    _backButton.imageEdgeInsets=UIEdgeInsetsMake(0.5*(_backButton.bounds.size.height-image.size.height),0, 0.5*(_backButton.bounds.size.height-image.size.height), _backButton.bounds.size.width-image.size.width-20);
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_nvView addSubview:_backButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, ScreenWidth(), 1)];
    lineView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [_nvView addSubview:lineView];
    [self.view addSubview:_nvView];
}
//如果isBack设置为no，将_backButton 移除父试图；
- (void)setIsBack:(BOOL )isBack{
    if (_backButton) {
        if (!isBack) {
            [_backButton removeFromSuperview];
        }
    }
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
