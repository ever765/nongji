//
//  MySetTableViewCell.m
//  nongji
//
//  Created by tobo on 17/4/11.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "MySetTableViewCell.h"
#define ViewFrameOriginX ViewWidth(50)
@interface MySetTableViewCell ()
{
    UILabel *_titleLabel;
    UIImageView *_rightImageView;
    UIView *_downLineView;
    NSInteger _index;
}
@end
@implementation MySetTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self crateCustomViews];
    }
    return self;
}

- (void)crateCustomViews{
    
    
    _titleLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@""];
    [self.contentView addSubview:_titleLabel];
    
    _rightImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_rightImageView];
    
    _downLineView = [[UIView alloc] init];
    _downLineView.backgroundColor = LINECOLOR;
    [self.contentView addSubview:_downLineView];
}

- (void)drewContentViewWithIndexPathRRow:(NSInteger)index{
    _index = index;
    NSArray *titleArray = @[@"在线升级",@"清除缓存",@"法律条例",@"关于我们"];
    _titleLabel.text = titleArray[index>titleArray.count?0:index];
    _rightImageView.image = [UIImage imageNamed:@"ic_right"];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGSize size = LabelSize(_titleLabel.text, titleFontSize);
    _titleLabel.frame = CGRectMake(ViewFrameOriginX, MaxY(self.contentView)/2 - size.height/2, size.width, size.height);
    
    _rightImageView.frame = CGRectMake(ScreenWidth() - ViewWidth(50) , MaxY(self.contentView)/2 - ViewWidth(15), ViewWidth(13), ViewWidth(30));
    
    _downLineView.frame = CGRectMake(ViewFrameOriginX,MaxY(_titleLabel)  + ViewWidth(9) , ScreenWidth() - ViewWidth(68), ViewWidth(1));
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
