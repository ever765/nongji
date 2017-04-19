//
//  PersonTableViewCell.m
//  nongji
//
//  Created by tobo on 17/4/8.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "PersonTableViewCell.h"

#define ViewFrameOriginX ViewWidth(88)

@interface PersonTableViewCell ()
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UIImageView *_rightImageView;
    UIView *_downLineView;
}

@end
@implementation PersonTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self crateCustomViews];
    }
    return self;
}

- (void)crateCustomViews{
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    _titleLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@""];
    [self.contentView addSubview:_titleLabel];
    
    _rightImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_rightImageView];
    
    _downLineView = [[UIView alloc] init];
    _downLineView.backgroundColor = LINECOLOR;
    [self.contentView addSubview:_downLineView];
}

- (void)drewContentViewWithIndexPathRRow:(NSInteger)index{
    NSArray *titleArray = @[@"个人资料",@"支出中心",@"历史订单",@"设置"];
    NSArray *imageNameS = @[@"ic_action_collection",@"ic_action_collection",@"ic_action_collection",@"ic_action_collection"];
    _imageView.image = [UIImage imageNamed:imageNameS[index>imageNameS.count?0:index]];
    _titleLabel.text = titleArray[index>titleArray.count?0:index];
    _rightImageView.image = [UIImage imageNamed:@"ic_right"];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(ViewFrameOriginX, ViewWidth(50), ViewWidth(60), ViewWidth(60));
    
    CGSize size = LabelSize(_titleLabel.text, titleFontSize);
    _titleLabel.frame = CGRectMake(MaxX(_imageView)  + ViewWidth(20), MaxY(_imageView) - size.height, size.width, size.height);
    
    _rightImageView.frame = CGRectMake(ScreenWidth() - ViewWidth(50) , MaxY(_imageView) - ViewWidth(30), ViewWidth(13), ViewWidth(30));
    
    _downLineView.frame = CGRectMake(ViewFrameOriginX,MaxY(_imageView)  + ViewWidth(10) , ScreenWidth() - ViewWidth(118), ViewWidth(1));
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
