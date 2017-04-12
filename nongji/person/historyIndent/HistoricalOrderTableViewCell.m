//
//  HistoricalOrderTableViewCell.m
//  nongji
//
//  Created by Cus on 2017/4/12.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "HistoricalOrderTableViewCell.h"
#define ViewFrameOriginX ViewWidth(50)
@interface HistoricalOrderTableViewCell ()
{
    UILabel *_nameLabel;
    UILabel *_phoneLabel;
    UILabel *_areaLabel;
    UILabel *_dateLabel;
    UIView *_downLineView;
}
@end

@implementation HistoricalOrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCustomViews];
    }
    return self;
}

- (void)createCustomViews{
    _nameLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"姓名:张三三"];
    [self.contentView addSubview:_nameLabel];
    
    _phoneLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"电话:1888888888"];
    [self.contentView addSubview:_phoneLabel];
    
    _areaLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"完成面积:80亩"];
    [self.contentView addSubview:_areaLabel];
    
    _dateLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"完成时间:2016-06-27"];
    [self.contentView addSubview:_dateLabel];
    
    _downLineView = [[UIView alloc] init];
    _downLineView.backgroundColor = LINECOLOR;
    [self.contentView addSubview:_downLineView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = LabelSize(_nameLabel.text, titleFontSize - 2);
    _nameLabel.frame = CGRectMake(ViewFrameOriginX, ViewWidth(40), size.width , size.height);
    size = LabelSize(_phoneLabel.text, titleFontSize - 2);
    _phoneLabel.frame = CGRectMake(ScreenWidth() - ViewFrameOriginX - size.width , MinY(_nameLabel), size.width, size.height);
    size = LabelSize(_areaLabel.text, titleFontSize - 2);
    _areaLabel.frame = CGRectMake(ViewFrameOriginX, MaxY(_nameLabel) + ViewWidth(20), size.width, size.height);
    size = LabelSize(_dateLabel.text, titleFontSize - 2);
    _dateLabel.frame = CGRectMake(ScreenWidth() - ViewFrameOriginX - size.width, MinY(_areaLabel), size.width, size.height);

    _downLineView.frame = CGRectMake(ViewFrameOriginX,MaxY(self.contentView) - ViewWidth(1) , ScreenWidth() - ViewWidth(118), ViewWidth(1));
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setDict:(NSDictionary *)dict{
    
}

@end
