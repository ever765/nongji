//
//  NJTabbarViewController.m
//  nongji
//
//  Created by tobo on 17/3/27.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "NJTabbarViewController.h"

#import "BaseViewController.h"


#import "HomeViewController.h"//首页
#import "CollectViewController.h"//收藏
#import "PersonViewController.h"//个人中心
#import "IndentViewController.h"//订单

#import "IssueViewController.h"//发布

#import "NJNVViewController.h"
#import "NJTabbarView.h"


@interface NJTabbarViewController ()<NJTabbarViewDelegate>
@property(nonatomic, weak)NJTabbarView *mainTabBar;
@property(nonatomic, strong)HomeViewController *homeVc;
@property(nonatomic, strong)IndentViewController *indentVc;
@property(nonatomic, strong)CollectViewController *collectVc;
@property(nonatomic, strong)PersonViewController *personVc;
@end

@implementation NJTabbarViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self SetupMainTabBar];
    [self SetupAllControllers];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)SetupMainTabBar{
    NJTabbarView *tabbar = [[NJTabbarView alloc] init];
    tabbar.frame = self.tabBar.bounds;
    tabbar.delegate = self;
    [self.tabBar addSubview:tabbar];
    _mainTabBar = tabbar;
}

- (void)SetupAllControllers{
    NSArray *titles = @[@"首页", @"订单", @"收藏", @"我的"];
    NSArray *images = @[@"add", @"add", @"add", @"add"];
    NSArray *selectedImages = @[@"add", @"add", @"add", @"add"];
    
    HomeViewController * homeVc = [[HomeViewController alloc] init];
    self.homeVc = homeVc;
    
    IndentViewController * indentVc = [[IndentViewController alloc] init];
    self.indentVc = indentVc;
    
    CollectViewController * collectVc = [[CollectViewController alloc] init];
    self.collectVc = collectVc;
    
    PersonViewController * personVc = [[PersonViewController alloc] init];
    self.personVc = personVc;
    
    NSArray *viewControllers = @[homeVc, indentVc, collectVc, personVc];
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *childVc = viewControllers[i];
        [self SetupChildVc:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)SetupChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    NJNVViewController *nav = [[NJNVViewController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.title = title;
    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
    [self addChildViewController:nav];
}



#pragma mark --------------------mainTabBar delegate
- (void)tabBar:(NJTabbarView *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag{
    self.selectedIndex = toBtnTag;
}

- (void)tabBarClickWriteButton:(NJTabbarView *)tabBar{
   IssueViewController  *issueVc = [[IssueViewController alloc] init];
    NJNVViewController *nav = [[NJNVViewController alloc] initWithRootViewController:issueVc];
    
    [self presentViewController:nav animated:YES completion:nil];
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
