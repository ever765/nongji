//
//  InformationTableViewCell.m
//  nongji
//
//  Created by tobo on 17/4/8.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "InformationTableViewCell.h"

#define ViewFrameOriginX ViewWidth(50)
@interface InformationTableViewCell ()<UIGestureRecognizerDelegate>
{
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UIImageView *_headerImageView;
    UIImageView *_rightImageView;
    UIImageView *_cardImageView;
    UIView *_lineView;
    NSInteger _index;
}

@end

@implementation InformationTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self crateCustomViews];
    }
    return self;
}

- (void)crateCustomViews{
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.image = [UIImage imageNamed:@"ic_action_integral"];
    [self.contentView addSubview:_headerImageView];
    
    _cardImageView = [[UIImageView alloc] init];
    _cardImageView.image = [UIImage imageNamed:@"lb_ic_img.9"];
    [self.contentView addSubview:_cardImageView];
    
    _titleLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@""];
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@"张三三"];
    [self.contentView addSubview:_contentLabel];
    
    _rightImageView = [[UIImageView alloc] init];
    _rightImageView.image = [UIImage imageNamed:@"ic_right"];
    [self.contentView addSubview:_rightImageView];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = LINECOLOR;
    [self.contentView addSubview:_lineView];
}

- (void)drewContentViewWithIndexPathRRow:(NSInteger)index{
    _index = index;
    [self clearFrame];
    NSArray *titleArray = @[@"个人信息",@"头像",@"姓名",@"电话",@"身份证"];
    _titleLabel.text = titleArray[index>titleArray.count?0:index];
    if (index == 3) {
        _contentLabel.text = @"1888888888";
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = LabelSize(_titleLabel.text, titleFontSize);
    _titleLabel.frame = CGRectMake(ViewFrameOriginX, ViewWidth(10), size.width, size.height);
    if (_index == 0) {
        _titleLabel.font = [UIFont boldSystemFontOfSize:titleFontSize + 2];
        size = LabelSize(_titleLabel.text, titleFontSize+2);
        _titleLabel.frame = CGRectMake(ViewFrameOriginX, ViewWidth(10), size.width, size.height);
    }else if (_index == 1){
        _titleLabel.frame = CGRectMake(ViewFrameOriginX, self.contentView.center.y - size.height/2, size.width, size.height);
        _headerImageView.frame = CGRectMake(ScreenWidth() - ViewWidth(190), self.contentView.center.y - ViewWidth(70), ViewWidth(140), ViewWidth(140));
        _headerImageView.layer.cornerRadius = ViewWidth(70);
        _headerImageView.layer.masksToBounds = YES;
    }
    if (_index == 2 || _index == 3) {
        size = LabelSize(_contentLabel.text, titleFontSize);
        _contentLabel.frame = CGRectMake(ScreenWidth() - ViewWidth(70) - size.width, MinY(_titleLabel), size.width, size.height);
    }
    if (_index == 3) {
        _rightImageView.frame = CGRectMake(MaxX(_contentLabel) + ViewWidth(20), MaxY(_contentLabel) - ViewWidth(30), ViewWidth(13), ViewWidth(30));
    }
    _lineView.frame = CGRectMake(ViewFrameOriginX,MaxY(self.contentView) - ViewWidth(1) , ScreenWidth() - ViewWidth(50), ViewWidth(1));
    if (_index == 4) {
        _lineView.frame = CGRectMake(0, 0, 0, 0);
        _cardImageView.frame = CGRectMake(MaxX(_titleLabel) - ViewWidth(30), MaxY(_titleLabel) + ViewWidth(20), ScreenWidth() - (MaxX(_titleLabel) - ViewWidth(30))*2, (ScreenWidth() - (MaxX(_titleLabel) - ViewWidth(30))*2)/4*3);
    }
 
 
}

-(void)clearFrame{
    _contentLabel.frame = CGRectMake(0, 0, 0, 0);
    _cardImageView.frame = CGRectMake(0, 0, 0, 0);
    _lineView.frame = CGRectMake(0, 0, 0, 0);
    _titleLabel.frame = CGRectMake(0, 0, 0, 0);
    _contentLabel.frame = CGRectMake(0, 0, 0, 0);
    _rightImageView.frame = CGRectMake(0, 0, 0, 0);
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
