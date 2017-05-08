//
//  NewsTableViewCell.m
//  nongji
//
//  Created by tobo on 17/5/2.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsListModel.h"
#import <UIImageView+WebCache.h>
#define ViewFrameOriginX ViewWidth(50)
@interface NewsTableViewCell ()
{
    UIImageView *_headImageView;
    UILabel *_titleLable;
    UILabel *_timeLable;
    UIView *_downLineView;
}
@end

@implementation NewsTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self crateCustomsView];
    }
    return self;
}


- (void)crateCustomsView{
    _headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImageView];
    
    
    _titleLable = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize - 3] inSize:CGSizeZero withText:@""];
    [self.contentView addSubview:_titleLable];
    
    _timeLable = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@""];
    [self.contentView addSubview:_timeLable];
    
    _downLineView = [[UIView alloc] init];
    _downLineView.backgroundColor = LINECOLOR;
    [self.contentView addSubview:_downLineView];
}


- (void)layoutSubviews{
    
    [super layoutSubviews];

    _headImageView.frame = CGRectMake(ViewFrameOriginX, ViewWidth(2), ViewWidth(120), self.frame.size.height - ViewWidth(4));
    _titleLable.frame = CGRectMake(MaxX(_headImageView) + ViewWidth(20), ViewWidth(10), ScreenWidth() - MaxX(_headImageView) + ViewWidth(20) - ViewFrameOriginX, ViewWidth(36));
    _timeLable.font = [UIFont systemFontOfSize:titleFontSize - 6];
    
    _timeLable.frame = CGRectMake(MinX(_titleLable), MaxY(self.contentView) - ViewWidth(24), ViewWidth(300), ViewWidth(20));
    _downLineView.frame = CGRectMake(MaxX(_headImageView), MaxY(self.contentView) - ViewWidth(2), ScreenWidth() - MaxX(_headImageView), ViewWidth(2));
}

- (void)setModel:(NewsListModel *)model{
    _model = model;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@dl?path=%@",NONGJIURL,_model.thumbnail]] placeholderImage:nil];
    _titleLable.text = _model.title;
    _timeLable.text = _model.createtime;
    
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
