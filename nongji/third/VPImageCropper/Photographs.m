//
//  Photographs.m
//  XiuCai
//
//  Created by tobo on 16/10/18.
//  Copyright © 2016年 WDX. All rights reserved.
//

#import "Photographs.h"
#import "VPImageCropperViewController.h"
#import "ScanView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <MobileCoreServices/MobileCoreServices.h>
#define ORIGINAL_MAX_WIDTH 640.0f
@interface Photographs ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,VPImageCropperDelegate>
{
    UIViewController *_viewController;
    UIImageView *_avatarView;
    NSString *_url;
}
@end
@implementation Photographs

#pragma mark -----头像修改
-(void)changeAvatar:(UIImageView *) avatarView withViewController:(UIViewController *)viewController withUrl:(NSString *)url
{
    _avatarView = avatarView;
    _url = url;
    _viewController = viewController;
    //弹出框
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *cameraButtonTitle = NSLocalizedString(@"拍照", nil);
    NSString *albumButtonTitle = NSLocalizedString(@"相册", nil);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击取消按钮");
    }];
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:cameraButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            NSString *errorStr = @"应用相机权限受限,请在 设置-隐私-相机 中启用";
            UIAlertController *view=[UIAlertController alertControllerWithTitle:nil message:errorStr preferredStyle:UIAlertControllerStyleAlert];
            [view addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root"]];
            }]];
            [viewController presentViewController:view animated:NO completion:nil];
        }
        [self imagePicker:UIImagePickerControllerSourceTypeCamera];
    }];
    alertController.view.frame = CGRectMake(0, 0, 10, 10);
    [alertController addAction:cameraAction];
    
    UIAlertAction * albumAction = [UIAlertAction actionWithTitle:albumButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //选择相册
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
            NSString *errorStr = @"应用相机权限受限,请在 设置-隐私-照片 中启用";
            UIAlertController *view=[UIAlertController alertControllerWithTitle:nil message:errorStr preferredStyle:UIAlertControllerStyleAlert];
            [view addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root"]];
            }]];
            [viewController presentViewController:view animated:NO completion:nil];
            return;
        }
        [self imagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:albumAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
    
}

//打开相机 或 相册
-(void)imagePicker:(NSUInteger) sourceType
{
    NSLog(@"选择了%@" , sourceType == UIImagePickerControllerSourceTypePhotoLibrary ? @"相册" :@"相机");
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.navigationBar.tintColor=[UIColor whiteColor];
    [imagePickerController.navigationBar setBarTintColor:[UIColor blackColor]];
    [imagePickerController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    if (sourceType != UIImagePickerControllerSourceTypePhotoLibrary) {
        ScanView *view  = [[ScanView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth(), ScreenHeight() - 144)];
        view.transparentArea = CGSizeMake(ScreenWidth() - 44, (ScreenWidth() - 44) / 3 * 2);
        view.backgroundColor = [UIColor clearColor];
        [imagePickerController.view addSubview:view];
    }
   
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [_viewController presentViewController:imagePickerController animated:YES completion:^{
        imagePickerController.delegate = self;
    }];
}

#pragma mark - 图片选择
//选择完成
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//        [self.certImageBtn setBackgroundImage:[info valueForKey:@"UIImagePickerControllerOriginalImage"] forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:^(void){
        //切图
        UIImage * portraitImg = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc]
                                                     initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, ScreenWidth() , ScreenWidth()/3*2) limitScaleRatio:3.0];
        
        imgEditorVC.delegate = self;
        
        [_viewController presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

#pragma mark -- 切图工具
-(void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)image {
    
    //将切过的图片数据
    NSData * imageData;
    //按图片类型转NSData
    NSString * imageType;
    NSString * filename;
    
    if( UIImagePNGRepresentation( image ) == nil ){
        imageType = @"image/png";
        imageData = UIImagePNGRepresentation( image ); //png
        filename = [NSString stringWithFormat:@"avatar_%f.png" , [[NSDate date] timeIntervalSince1970] * 1000 ];
        
    } else {
        imageType = @"image/jpg";
        imageData = UIImageJPEGRepresentation( image , 1); //jpg
        filename = [NSString stringWithFormat:@"avatar_%f.jpg" , [[NSDate date] timeIntervalSince1970] * 1000 ];
    }
     NSLog(@"%@",filename);
    [_avatarView setImage:image];
  /*  //开始上传头像
    //显示进度条
     UIActivityIndicatorView * indicator = [Common getIndicator:self.view];
     [indicator startAnimating];
     
     
     AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
     //设置token
     [manager.requestSerializer setValue:[Common getToken] forHTTPHeaderField:@"token"];
     [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"mt"];
     
     [manager
     POST:[Common getApiUrl:@"member/info/headicon"]
     parameters:nil
     constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
     
     [formData appendPartWithFileData:imageData name:@"file" fileName:filename mimeType:imageType];
     
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
     [indicator stopAnimating];
     if ( [[responseObject objectForKey:@"status"] isEqualToString:@"OK"]) {
     
     [self message:[responseObject objectForKey:@"message"]];
     
     
     [API get:@"member/info/personal" Params:nil Resp:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSLog(@"member/info/personal : %@" , responseObject);
     NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"]  options:0 error:nil];
     NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] initWithDictionary:dict];
     [ dict2 setObject:[[responseObject objectForKey:@"data"] objectForKey:@"head_icon"] forKey:@"head_icon"];
     NSData *data = [NSJSONSerialization dataWithJSONObject:dict2 options:NSJSONWritingPrettyPrinted error:nil];
     [Common setUserInfo:data];
     
     }];
     }
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     [self message:@"网络错误，上传头像失败"];
     [indicator stopAnimating];
     }];
     */
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        //TO DO
    }];
}

- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
@end
