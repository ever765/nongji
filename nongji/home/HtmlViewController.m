//
//  HtmlViewController.m
//  nongji
//
//  Created by Cus on 2017/4/19.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "HtmlViewController.h"

@interface HtmlViewController ()

@end

@implementation HtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *view = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth(), ScreenHeight())];
    [self.view addSubview:view];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"html"];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSString *basePath = [[NSBundle mainBundle] bundlePath];
    
    NSURL *baseURL = [NSURL fileURLWithPath:basePath];
    
    [view loadHTMLString:htmlString baseURL:baseURL];
   
    // Do any additional setup after loading the view.
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
