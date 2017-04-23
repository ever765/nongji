//
//  CancelIssueViewController.m
//  nongji
//
//  Created by tobo on 17/4/23.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "CancelIssueViewController.h"

@interface CancelIssueViewController ()<UITextViewDelegate>{
    UITextView *_contentTextView;
    UILabel *_label;
}

@end

@implementation CancelIssueViewController

- (NSString *)navigationTitleText{
    return @"取消原因";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTextView];
    [self createButton];
    // Do any additional setup after loading the view.
}

- (void)createTextView{
    _contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(ViewWidth(88), ViewWidth(480), ScreenWidth() - ViewWidth(176), (ScreenWidth() - ViewWidth(176)) / 3 * 2)];
    _contentTextView.layer.borderWidth = 1;
    _contentTextView.font = [UIFont systemFontOfSize:titleFontSize];
    _contentTextView.delegate = self;
    [self.view addSubview:_contentTextView];
    
    _label = [MyTools lableWithtextColor:UIColorFromRGB(0xeeeeee) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@"请填写原因"];
    CGSize size = LabelSize(_label.text, titleFontSize );
    _label.frame = CGRectMake(viewWidth(_contentTextView)/2 - size.width / 2, (viewHeight(_contentTextView) - size.height) / 2, size.width, size.height);
    [_contentTextView addSubview:_label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//订单确认
- (void)createButton{
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(0 , ScreenHeight() - ViewWidth(88),ScreenWidth(), ViewWidth(88));
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    submitButton.backgroundColor = UIColorFromRGB(0x1784CA);
    [submitButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 2];
    [submitButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:submitButton];
}

- (void)buttonAction:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""]) {
        _label.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _label.hidden = NO;
    }
    
    return YES;
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
