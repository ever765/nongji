//
//  AboutAppViewController.m
//  nongji
//
//  Created by tobo on 17/4/11.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "AboutAppViewController.h"

#define ViewFrameOriginX ViewWidth(88)
@interface AboutAppViewController ()

@end

@implementation AboutAppViewController

- (void)viewDidLoad {
    self.vcTitle = @"关于我们";
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView{
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    NSArray *array = @[@"南京节点软件科技有限公司",@"电话：158502881293",@"邮箱：node@server.com",@"网址：www.sanwudou.com",@"地址：江宁区胜利西路9号"];
    
    for (NSInteger i = 0; i<array.count; i++) {
        UILabel *label = [MyTools lableWithtextColor:UIColorFromRGB(0x666666) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:array[i]];
        CGSize size = LabelSize(label.text, titleFontSize - 2);
        label.frame = CGRectMake(ViewFrameOriginX,64 + ViewWidth(40) + i * (size.height + ViewWidth(20)), size.width, size.height);
        [self.view addSubview:label];
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
