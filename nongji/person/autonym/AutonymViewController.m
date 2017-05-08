//
//  AutonymViewController.m
//  nongji
//
//  Created by tobo on 17/5/3.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "AutonymViewController.h"
#import "Photographs.h"
#import "AFNetworking.h"
@interface AutonymViewController ()<UIGestureRecognizerDelegate>
{
    UITextField *_idCardTextField;
    UIImageView *_imageView;
    UIImageView *_idCardImageView;
     Photographs *_photo;
    UIImage *_upImage;
    UIImage *_downImage;
}
@end

@implementation AutonymViewController


- (NSString *)navigationTitleText{
    return @"实名认证";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    UILabel *nameLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize  - 2 ] inSize:CGSizeZero withText:@"身份证号"];
    CGSize size = LabelSize(nameLabel.text, titleFontSize - 2);
    nameLabel.frame = CGRectMake(ViewWidth(30), 64 + ViewWidth(20), size.width, size.height);
    [self.view addSubview:nameLabel];
    
    _idCardTextField = [[UITextField alloc] init];
    _idCardTextField.placeholder = @"请输入身份证号";
     size = LabelSize(@"8888888888888888888", titleFontSize - 2);
    _idCardTextField.font = [UIFont systemFontOfSize:titleFontSize - 2];
    _idCardTextField.textAlignment = NSTextAlignmentRight;
    _idCardTextField.frame = CGRectMake(ScreenWidth() - size.width, 64 + ViewWidth(20), size.width, size.height);
    [self.view addSubview:_idCardTextField];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, MaxY(_idCardTextField) + ViewWidth(20), ScreenWidth(), ViewWidth(1))];
    view.backgroundColor = LINECOLOR;
    [self.view addSubview:view];
    
    UILabel *imageLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize  - 2 ] inSize:CGSizeZero withText:@"身份证照片"];
    size = LabelSize(imageLabel.text, titleFontSize - 2);
    imageLabel.frame = CGRectMake(ViewWidth(30), MaxY(_idCardTextField) + ViewWidth(40), size.width, size.height);
    [self.view addSubview:imageLabel];
    
    _idCardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth() / 2 -ViewWidth(200) , MaxY(imageLabel) + ViewWidth(20), ViewWidth(400), ViewWidth(300))];
    _upImage = [UIImage imageNamed:@"ic_id"];
    _idCardImageView.image = _upImage;
    _idCardImageView.layer.borderWidth = ViewWidth(1);
    [self.view addSubview:_idCardImageView];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrAction:)];
    _idCardImageView.userInteractionEnabled = YES;
    [_idCardImageView addGestureRecognizer:tgr];
    
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth() / 2 -ViewWidth(200) , MaxY(_idCardImageView) + ViewWidth(20), ViewWidth(400), ViewWidth(300))];
    _downImage = [UIImage imageNamed:@"up"];
    _imageView.image = _downImage;
    [self.view addSubview:_imageView];
    _imageView.layer.borderWidth = ViewWidth(1);
    UITapGestureRecognizer *tr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrAction:)];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:tr];
    
    
    UILabel *label = [MyTools lableWithtextColor:UIColorFromRGB(0xcc3333) textFont:[UIFont systemFontOfSize:titleFontSize  - 4] inSize:CGSizeZero withText:@"温馨提示:根据提示拍摄相应的图片"];
    size = LabelSize(label.text, titleFontSize - 4);
    label.frame = CGRectMake(ViewWidth(30), MaxY(_imageView) + ViewWidth(20), size.width, size.height);
    [self.view addSubview:label];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(ViewWidth(50),   MaxY(label) + ViewWidth(50),ScreenWidth() - ViewWidth(100), ViewWidth(88));
    submit.layer.masksToBounds = YES;
    submit.layer.cornerRadius = ViewWidth(44);
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    submit.backgroundColor = UIColorFromRGB(0x1784CA);
    [submit setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    submit.titleLabel.font = [UIFont systemFontOfSize:titleFontSize - 2];
    [submit addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:submit];
}

- (void)tgrAction:(UITapGestureRecognizer *)tgr
{
    _photo = [[Photographs alloc] init];
    UIImageView *view = (UIImageView *)tgr.view;
    [_photo changeAvatar:view withViewController:self withUrl:nil];
}


- (void)buttonAction:(UIButton *)btn{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSData *upData;
    NSData *downData;
    if ([NSString stringIsIdentity:_idCardTextField.text withViewController:self ]) {
        return;
    }
    if (![_upImage isEqual:_idCardImageView.image] && ![_downImage isEqual:_imageView.image]) {
        upData = [MyTools getImageCompress:_idCardImageView.image];
        downData = [MyTools getImageCompress:_imageView.image];
    }else{
        [self showHint:@"请选择照片"];
    }
    
    
    [manager POST:[NSString stringWithFormat:@"%@",NONGJIURL] parameters:@{@"id":GETUSERID} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if ( upData && downData ) {
            [formData appendPartWithFileData:upData name:@"file" fileName:[NSString stringWithFormat:@"image[%d].png",1] mimeType:@"image/png"];
            [formData appendPartWithFileData:downData name:@"file" fileName:[NSString stringWithFormat:@"image[%d].png",1] mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"OK"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            [self showHint:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self showHint:@"请求失败"];
        
    }];
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
