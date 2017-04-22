//
//  IssueSetTableViewCell.m
//  nongji
//
//  Created by tobo on 17/4/21.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "IssueSetTableViewCell.h"

#define ViewFrameOriginX ViewWidth(50)
@interface IssueSetTableViewCell ()
{
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UIView *_downLineView;
    NSInteger _index;
}
@end
@implementation IssueSetTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self crateCustomViews];
    }
    return self;
}
- (void)crateCustomViews{
    _titleLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@""];
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"80元/亩"];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_contentLabel];
    
    _downLineView = [[UIView alloc] init];
    _downLineView.backgroundColor = LINECOLOR;
    [self.contentView addSubview:_downLineView];
}

- (void)drewContentViewWithIndexPathRRow:(NSInteger)index{
    _index = index;
    [self clearFrame];
    NSArray *titleArray = @[@"姓名",@"电话",@"距离",@"是否跨区",@"农机1",@"农机2",@"理想报价",@"机手报价",@"完成面积",@"接单时间"];
    NSArray *contentArray =@[@"李四",@"1888888888",@"128公里",@"是",@"旋耕机",@"联合收割机",@"80元/亩",@"90亩",@"2016-06-27"];
    _titleLabel.text = titleArray[index>titleArray.count -1?0:index];
    _contentLabel.text = contentArray[index>contentArray.count -1?0:index];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self clearFrame];
    CGSize size = LabelSize(_titleLabel.text, titleFontSize - 2);
    _downLineView.frame = CGRectMake(ViewFrameOriginX,MaxY(self.contentView) - ViewWidth(1) , ScreenWidth() - ViewWidth(50), ViewWidth(1));
    _titleLabel.frame = CGRectMake(ViewFrameOriginX, self.contentView.center.y - size.height/2, size.width, size.height);
    
    size = MoreLineLabelSize(_contentLabel.text, ScreenWidth() - MaxX(_titleLabel) - ViewFrameOriginX - ViewWidth(20), titleFontSize - 2);
    _contentLabel.frame = CGRectMake(  ScreenWidth() - ViewFrameOriginX - size.width , MinY(_titleLabel), size.width, size.height);
    
    
}

-(void)clearFrame{
    _titleLabel.frame = CGRectMake(0, 0, 0, 0);
    _contentLabel.frame = CGRectMake(0, 0, 0, 0);
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
