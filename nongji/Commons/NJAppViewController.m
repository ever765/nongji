//
//  NJAppViewController.m
//  nongji
//
//  Created by tobo on 17/3/27.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "NJAppViewController.h"
#import <Masonry.h>
#import "AHSKitMacro.h"

@interface NJAppViewController ()
//自定义下划线
{
    UIView *_navDownLineView;
}
// 自定义中间视图
@property (nonatomic, strong) UIView *navCenterView;

// 自定义左边按钮(back)
@property (nonatomic, strong) UIButton *navLeftButton;

// 自定义右边按钮
@property (nonatomic, strong) UIButton *navRightButton;



@end

@implementation NJAppViewController

#pragma mark -- setter && getter
- (UIView *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, KNAV_HEIGHT)];
        _customNavBar.backgroundColor = UIColorFromRGB(0x1784CA);
    }
    return _customNavBar;
}

- (UIView *)navCenterView
{
    if (_navCenterView == nil) {
        _navCenterView = [[UIView alloc] initWithFrame:CGRectMake(KNAV_BUTTON_WIDTH, KSTATUS_HEIGHT, kSCREEN_WIDTH - 2.f * KNAV_BUTTON_WIDTH, KNAVBAR_HEIGHT)];
    }
    return _navCenterView;
}

- (UIButton *)navLeftButton
{
    if (_navLeftButton == nil) {
        _navLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _navLeftButton.frame = CGRectMake(0, KSTATUS_HEIGHT, KNAV_BUTTON_WIDTH, KNAVBAR_HEIGHT);
        [_navLeftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _navLeftButton;
}

- (UIButton *)navRightButton
{
    if (_navRightButton == nil) {
        _navRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _navRightButton.frame = CGRectMake(kSCREEN_WIDTH - KNAV_BUTTON_WIDTH, KSTATUS_HEIGHT, KNAV_BUTTON_WIDTH, KNAVBAR_HEIGHT);
    }
    return _navRightButton;
}

#pragma mark -- public
- (UIView *)navigationTitleView
{
    return nil;
}
- (NSString *)navigationTitleText
{
    return nil;
}

- (UIView *)navigationLeftView
{
    return nil;
}
- (UIImage *)navigationLeftImage
{
    return nil;
}
- (NSString *)navigationLeftTitle
{
    return nil;
}
- (void)navigationLeftAction:(id)sender
{
    // 左边back的默认实现，不需要back时才需重写
    [self closeMeAnimated:YES];
}

- (UIView *)navigationRightView
{
    return nil;
}
- (UIImage *)navigationRightImage
{
    return nil;
}
- (NSString *)navigationRightTitle
{
    return nil;
}

- (void)navigationRightAction:(id)sender
{
    // 右边按钮的实现，需在子类重写
}

- (void)setIsHiddenNaVc:(BOOL)isHiddenNaVc{
    _isHiddenNaVc = isHiddenNaVc;
    if (isHiddenNaVc) {
        [_customNavBar removeFromSuperview];
    }
}

#pragma mark -- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    self.firstAppear = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.view.backgroundColor = [ECColorConfig appBackgroundColor];
    // 配置自定义导航栏
    [self configNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.firstAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- private
- (void)configNavigationBar
{
    // 隐藏系统导航栏，但不禁用侧滑手势
    self.navigationController.navigationBar.hidden = YES;
    // 添加自定义导航
    [self.view addSubview:self.customNavBar];
    // 中间视图
    [self _configNavCenterView];
    // 左侧按钮
    [self _configNavLeftButton];
    // 右侧按钮
    [self _configNavRightButton];
    //底部分割条
//    [self _configNavDownLineView];
}

- (void)_configNavDownLineView{
    if (!_navDownLineView) {
        _navDownLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, kSCREEN_WIDTH, 1)];
        _navDownLineView.backgroundColor = UIColorFromRGB(0xeeeeee);
        [_customNavBar addSubview:_navDownLineView];
    }
    
}

- (void)_configNavCenterView
{
    if ([self navigationTitleView]) {
        UIView *titleView = [self navigationTitleView];
        titleView.center = CGPointMake(self.navCenterView.bounds.size.width / 2.f, self.navCenterView.bounds.size.height / 2.f);
        [self.navCenterView addSubview:titleView];
    } else if ([self navigationTitleText]) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.navCenterView.bounds];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        //        titleLabel.font = [UIFont fontWithStyle:@"Helvetica-Bold" fontSize:18.f];
        titleLabel.text = [self navigationTitleText];
        titleLabel.textColor = [UIColor whiteColor];
        [self.navCenterView addSubview:titleLabel];
    }
    
    [self.customNavBar addSubview:self.navCenterView];
}

- (void)_configNavLeftButton
{
    if ([self navigationLeftView]) {
        UIView *leftView = [self navigationLeftView];
        leftView.frame = self.navLeftButton.bounds;
        [self.customNavBar addSubview:self.navLeftButton];
        [self.navLeftButton addSubview:leftView];
        return;
    }
    
    UIImage *leftButtonImage = [self navigationLeftImage];
    NSString *leftButtonTitle = [[self navigationLeftTitle] stringByReplacingOccurrencesOfString:@" " withString:@""];
    BOOL byPush = (self != self.navigationController.viewControllers.firstObject ||
                   self.navigationController.presentingViewController != nil);
    
    if (leftButtonImage == nil && byPush && leftButtonTitle == nil){
        [self.navLeftButton setImage:[UIImage imageNamed:@"ic_return"] forState:UIControlStateNormal];
    }else if(leftButtonImage){
        [self.navLeftButton setImage:leftButtonImage forState:UIControlStateNormal];
    } else if (leftButtonTitle) {
        [self.navLeftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
        self.navLeftButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    }
    [self.navLeftButton addTarget:self action:@selector(navigationLeftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBar addSubview:self.navLeftButton];
}

- (void)_configNavRightButton
{
    if ([self navigationRightView]) {
        UIView *rightView = [self navigationRightView];
        rightView.frame = self.navRightButton.bounds;
        [self.customNavBar addSubview:self.navRightButton];
        [self.navRightButton addSubview:rightView];
        return;
    }
    
    UIImage *rightButtonImage = [self navigationRightImage];
    NSString *rightButtonTitle = [[self navigationRightTitle] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (rightButtonImage == nil && rightButtonTitle == nil) {
        return;
    }
    
    if (rightButtonImage) {
        [self.navRightButton setImage:rightButtonImage forState:UIControlStateNormal];
    } else if (rightButtonTitle) {
        [self.navRightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
        self.navRightButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    }
    
    [self.navRightButton addTarget:self action:@selector(navigationRightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.customNavBar addSubview:self.navRightButton];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark -- event
- (void) closeMeAnimated:(BOOL)animated {
    if (self.navigationController == nil && self.presentingViewController != nil){
        [self dismissViewControllerAnimated:animated completion:^{}];
        return;
    }
    
    if ([self.navigationController.viewControllers firstObject] == self){
        if (self.navigationController.presentingViewController != nil){
            [self.navigationController dismissViewControllerAnimated:animated completion:^{}];
        }
    }
    else{
        [self.navigationController popViewControllerAnimated:animated];
    }
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
