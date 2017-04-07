//
//  NJAppViewController.h
//  nongji
//
//  Created by tobo on 17/3/27.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJAppViewController : UIViewController
{
    UIView *_nvView;//设置导航view。 代替导航的view；
    UILabel *_titileLabel;
    UIButton *_backButton;
}
//设置头文件
@property(nonatomic,strong)NSString *vcTitle;
//设置是否返回。no。不返回。 yes。返回
@property(nonatomic,assign)BOOL isBack;
@end
