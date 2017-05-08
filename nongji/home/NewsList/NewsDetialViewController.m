//
//  NewsDetialViewController.m
//  nongji
//
//  Created by tobo on 17/5/3.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "NewsDetialViewController.h"
#import "NewsListModel.h"
#import <UIImageView+WebCache.h>
#define ViewFrameOriginX ViewWidth(50)
@interface NewsDetialViewController ()
{
    UIScrollView *_scrollView;
    UILabel *_titleLabel;
    UILabel *_timeLabel;
    UIImageView *_imageView;
    UILabel *_contentLabel;
}
@end

@implementation NewsDetialViewController

- (NSString *)navigationTitleText{
    return @"资讯信息";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth(), ScreenHeight() - 64)];
    [self.view addSubview:_scrollView];
    _titleLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x646464) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@""];
    _titleLabel.text = _model.title;
    _titleLabel.numberOfLines = 0;
    CGSize size = MoreLineLabelSize(_titleLabel.text, ScreenWidth() - ViewFrameOriginX * 2, titleFontSize - 2);
    _titleLabel.frame = CGRectMake(ViewFrameOriginX,  ViewWidth(20), size.width , size.height);
    [_scrollView addSubview:_titleLabel];
    
    _timeLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x888888) textFont:[UIFont systemFontOfSize:titleFontSize - 4] inSize:CGSizeZero withText:@""];
    _timeLabel.text = [NSString stringWithFormat:@"三五斗   %@" ,_model.createtime ];
    size = LabelSize(_timeLabel.text, titleFontSize - 2);
    _timeLabel.frame = CGRectMake(ViewFrameOriginX,MaxY(_titleLabel) + ViewWidth(20), size.width , size.height);
    [_scrollView addSubview:_timeLabel];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewFrameOriginX, MaxY(_timeLabel) + ViewWidth(20), ScreenWidth() - 2 * ViewFrameOriginX, (ScreenWidth() - 2 * ViewFrameOriginX) / 3 * 2)];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@dl?path=%@",NONGJIURL,_model.thumbnail]] placeholderImage:nil];
    [_scrollView addSubview:_imageView];
    
    _contentLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x646464) textFont:[UIFont systemFontOfSize:titleFontSize - 4] inSize:CGSizeZero withText:@""];
    _contentLabel.numberOfLines = 0;
//     NSArray *array = [_model.content componentsSeparatedByString:@"\n"];
//    NSString *contentText;
//    for (NSString *str in array) {
//        contentText = [contentText stringByAppendingFormat:@"    %@\n",str];
//    }
    _contentLabel.text = _model.content;
     size = MoreLineLabelSize(_contentLabel.text, ScreenWidth() - ViewFrameOriginX * 2, titleFontSize - 4);
    _contentLabel.frame = CGRectMake(ViewFrameOriginX,MaxY(_imageView) + ViewWidth(20), size.width , size.height);
    [_scrollView addSubview:_contentLabel];
    _scrollView.contentSize = CGSizeMake(0, MaxY(_contentLabel));
}

- (void)setModel:(NewsListModel *)model{
    _model = model;
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
