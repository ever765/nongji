//
//  MachineDetialViewController.m
//  nongji
//
//  Created by tobo on 17/5/3.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "MachineDetialViewController.h"
#import <UIImageView+WebCache.h>
#define ViewFrameOriginX ViewWidth(50)
@interface MachineDetialViewController ()
{
    UIImageView *_imageView;//头像
    UILabel *_namelabel;//姓名
    UILabel *_timelabel;//从业时间
    UILabel *_sexlabel;//性别
//    UILabel *_agelabel;//年龄
    UILabel *_numberlabel;//完成单数
    UILabel *_characterlabel;//品质
    UILabel *_typelabel;//类型
    UILabel *_approvelabel;//是否认证
    UILabel *_addresslabel;//作业地点
    UILabel *_starlabel;//评分
}
@end

@implementation MachineDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initData{
    [API requestVerificationAFURL:[NSString stringWithFormat:@"%@/user/info?userId=%@",NONGJIURL,_Id] httpMethod:METHOD_GET parameters:nil Authorization:nil viewController:self succeed:^(id responseObject) {
        if (responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
           [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@dl?path=%@",NONGJIURL,dict[@"message"][@"user"][@"headimage"]]]];
            
            _namelabel.text = [self isNotNull:dict[@"message"][@"user"][@"realName"]]?dict[@"message"][@"user"][@"realName"]:@"未知";
            
            _timelabel.text = [NSString stringWithFormat:@"从业时间：%@" ,dict[@"message"][@"user"][@"workingTime"]];
            
            _sexlabel.text = [NSString stringWithFormat:@"性别：%@" ,[self isNotNull:dict[@"message"][@"user"][@"gender"]]?dict[@"message"][@"user"][@"gender"]:@"男"];
            
//            _agelabel.text = [NSString stringWithFormat:@"年龄：%@",dict[@"message"][@"user"][@"workingTime"]];
            
            _numberlabel.text = [NSString stringWithFormat:@"已完成的订单数量：%@" ,[self isNotNull:dict[@"message"][@"orderNumber"]]?dict[@"message"][@"orderNumber"]:@"0"];
            _characterlabel.text = [NSString stringWithFormat:@"作业品种：%@",dict[@"message"][@"user"][@"serviceVri"]];
            _typelabel.text = [NSString stringWithFormat:@"作业类型：%@" ,dict[@"message"][@"user"][@"serviceType"]];
            NSString *str;
            switch ([dict[@"message"][@"user"][@"userstate"] integerValue]) {
                case 0:
                    str = @"未认证";
                    break;
                case 1:
                    str = @"审核中";
                    break;
                case 9:
                    str = @"已认证";
                    break;
                default:
                    str = @"未认证";
                    break;
            }
            
            _approvelabel.text = [NSString stringWithFormat:@"是否认证：%@" , str];
            _addresslabel.text = [NSString stringWithFormat:@"作业地点：%@", dict[@"message"][@"user"][@"workArea"]];
            _starlabel.text = [NSString stringWithFormat:@"评价得分：%@ 分" ,@"0"];
        }
    } failure:^(NSError *error) {
        
    }];
}


- (BOOL)isNotNull:(id)str{
    if ([str isEqual:[NSNull null]]) {
        return NO;
    }
    return YES;
}

- (void)initView{
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth(), ViewWidth(150))];
    view.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewFrameOriginX, ViewWidth(10), viewHeight(view) -ViewWidth(20), viewHeight(view) -ViewWidth(20))];
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = _imageView.frame.size.height/2;
    [view addSubview:_imageView];
    
    _namelabel = [MyTools lableWithtextColor:UIColorFromRGB(0x1784CA) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@""];
    CGSize size = LabelSize(@"呜呜呜呜", titleFontSize);
    _namelabel.frame = CGRectMake(MaxX(_imageView) + ViewWidth(20), MinY(_imageView), size.width, size.height);
    [view addSubview:_namelabel];
    
    _timelabel = [MyTools lableWithtextColor:UIColorFromRGB(0x646464) textFont:[UIFont systemFontOfSize:titleFontSize - 4] inSize:CGSizeZero withText:@""];
     size = LabelSize(@"从业时间：2016、2、2 13：20：11", titleFontSize - 4 );
    _timelabel.frame = CGRectMake(MinX(_namelabel), MaxY(_namelabel) +ViewWidth(10), size.width, size.height);
    [view addSubview:_timelabel];
    
    _sexlabel = [MyTools lableWithtextColor:UIColorFromRGB(0x646464) textFont:[UIFont systemFontOfSize:titleFontSize - 4] inSize:CGSizeZero withText:@""];
    size = LabelSize(@"性别：男", titleFontSize - 4);
    _sexlabel.frame = CGRectMake(MinX(_namelabel), MaxY(_timelabel) +ViewWidth(10), size.width, size.height);
    [view addSubview:_sexlabel];
//    
//    _agelabel = [MyTools lableWithtextColor:UIColorFromRGB(0x646464) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@""];
//    size = LabelSize(@"年龄:888", titleFontSize);
//    _agelabel.frame = CGRectMake(MaxX(_sexlabel) + ViewWidth(20), MaxY(_namelabel) +ViewWidth(10), size.width, size.height);
//    [view addSubview:_agelabel];
    [self.view addSubview:view];
    
    UIView *numberView = [[UIView alloc] initWithFrame:CGRectMake(0, MaxY(view) + ViewWidth(10), ScreenWidth(), ViewWidth(66))];
    numberView.backgroundColor = UIColorFromRGB(0xffffff);
    
    _numberlabel = [MyTools lableWithtextColor:UIColorFromRGB(0x646464) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@""];
    size = LabelSize(@"已完成的订单数:999324324", titleFontSize);
    _numberlabel.frame = CGRectMake(ViewFrameOriginX,ViewWidth(33) - size.height/2, size.width, size.height);
    [numberView addSubview:_numberlabel];
    [self.view addSubview:numberView];
    
    UIView *workView = [[UIView alloc] initWithFrame:CGRectMake(0, MaxY(numberView) + ViewWidth(10), ScreenWidth(), ViewWidth(400))];
    workView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UILabel *label  = [MyTools lableWithtextColor:UIColorFromRGB(0x646464) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"作业能力"];
    size = LabelSize(label.text, titleFontSize);
    label.frame = CGRectMake(ViewFrameOriginX,ViewWidth(33) - size.height/2, size.width, size.height);
    [workView addSubview:label];
    
    UIView *upLineView = [[UIView alloc]initWithFrame:CGRectMake(ViewFrameOriginX, ViewWidth(66), ScreenWidth() - 2*ViewFrameOriginX, ViewWidth(2)) ];
    upLineView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [workView addSubview:upLineView];
    
     _characterlabel = [MyTools lableWithtextColor:UIColorFromRGB(0x646464) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@""];
    size = LabelSize(@"作业品种：水电费救死扶伤", titleFontSize);
    _characterlabel.frame = CGRectMake(ViewFrameOriginX * 2,ViewWidth(66) + ViewWidth(20), size.width, size.height);
    [workView addSubview:_characterlabel];
    
    _typelabel = [MyTools lableWithtextColor:UIColorFromRGB(0x646464) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@""];
    size = LabelSize(@"作业品种：水电费救死扶伤", titleFontSize);
    _typelabel.frame = CGRectMake(MinX(_characterlabel),MaxY(_characterlabel) + ViewWidth(10), size.width, size.height);
    [workView addSubview:_typelabel];
    
    _approvelabel = [MyTools lableWithtextColor:UIColorFromRGB(0x646464) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@""];
    size = LabelSize(@"作业品种：水电费救死扶伤", titleFontSize);
    _approvelabel.frame = CGRectMake(MinX(_characterlabel),MaxY(_typelabel) + ViewWidth(10),  size.width, size.height);
    [workView addSubview:_approvelabel];
    
    _addresslabel = [MyTools lableWithtextColor:UIColorFromRGB(0x646464) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@""];
    size = LabelSize(@"作业品种：水电费救死扶伤", titleFontSize);
    _addresslabel.frame = CGRectMake(MinX(_characterlabel),MaxY(_approvelabel) + ViewWidth(10), size.width, size.height);
    [workView addSubview:_addresslabel];
    
    UIView *downLineView = [[UIView alloc]initWithFrame:CGRectMake(ViewFrameOriginX, viewHeight(workView) - ViewWidth(66), ScreenWidth() - 2*ViewFrameOriginX, ViewWidth(2)) ];
    downLineView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [workView addSubview:downLineView];
    [self.view addSubview:workView];
    
    UIView *starView = [[UIView alloc] initWithFrame:CGRectMake(0, MaxY(workView) +ViewWidth(10), ScreenWidth(), ViewWidth(66))];
    starView.backgroundColor = UIColorFromRGB(0xffffff);
    
    _starlabel = [MyTools lableWithtextColor:UIColorFromRGB(0x646464) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@""];
    size = LabelSize(@"作业品种：水电费救死扶伤", titleFontSize);
    _starlabel.frame = CGRectMake(MinX(label),ViewWidth(33) - size.height/2, size.width, size.height);
    [starView addSubview:_starlabel];
    
    [self.view addSubview:starView];

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
