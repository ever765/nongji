//
//  HomeTableViewCell.m
//  nongji
//
//  Created by tobo on 17/4/24.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeModel.h"
#import <UIImageView+WebCache.h>

#define ViewFrameOriginX ViewWidth(50)

@interface HomeTableViewCell ()
{
    UIImageView *_headImageView;
    UIImageView *_contentImageView;
    UILabel *_titleLable;
    UILabel *_timeLable;
    UILabel *_contentLable;
    UILabel *_distanceLable;
    UIView *_downLineView;
    NSString *_cellID;
}
@end

@implementation HomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    _cellID = reuseIdentifier;
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self crateCustomsView];
    }
    return self;
}


- (void)crateCustomsView{
    
    _headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_headImageView];
    
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.image = [UIImage imageNamed:@"ic_action_position"];
    [self.contentView addSubview:_contentImageView];
    
    
    _titleLable = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@""];
    [self.contentView addSubview:_titleLable];
    
    _timeLable = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@""];
    [self.contentView addSubview:_timeLable];
    
    _contentLable = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@""];
    [self.contentView addSubview:_contentLable];
    
    _distanceLable = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:@""];
    [self.contentView addSubview:_distanceLable];
    
    _downLineView = [[UIView alloc] init];
    _downLineView.backgroundColor = LINECOLOR;
    [self.contentView addSubview:_downLineView];
    
}


- (void)setModel:(NewsModel *)model{
    _model = model;
    [self clearFrame];
}



- (void)setMode:(ListModel *)mode{
    _mode = mode;
}



- (void)clearFrame{
    _headImageView.frame = CGRectMake(0, 0, 0, 0);
    _titleLable.frame = CGRectMake(0, 0, 0, 0);
    _timeLable.frame = CGRectMake(0, 0, 0, 0);
    _distanceLable.frame = CGRectMake(0, 0, 0, 0);
    _contentLable.frame = CGRectMake(0, 0, 0, 0);
    _contentImageView.frame = CGRectMake(0, 0, 0, 0);
}



- (void)layoutSubviews{
    [super layoutSubviews];
    [self clearFrame];
    if ([_cellID isEqualToString:@"cellId0"]) {
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@dl?path=%@",NONGJIURL,_model.thumbnail]] placeholderImage:nil];
        _headImageView.frame = CGRectMake(ViewFrameOriginX, ViewWidth(2), ViewWidth(120), self.frame.size.height - ViewWidth(4));
         _headImageView.layer.cornerRadius = 0;
        _titleLable.text = _model.content;
        _timeLable.font = [UIFont systemFontOfSize:titleFontSize - 2];
        _titleLable.frame = CGRectMake(MaxX(_headImageView) + ViewWidth(20), ViewWidth(10), ScreenWidth() - MaxX(_headImageView) + ViewWidth(20) - ViewFrameOriginX, ViewWidth(36));
        
        
        _timeLable.text = _model.createtime;
        _timeLable.font = [UIFont systemFontOfSize:titleFontSize - 6];
        
        _timeLable.frame = CGRectMake(MinX(_titleLable), MaxY(self.contentView) - ViewWidth(24), ViewWidth(300), ViewWidth(20));
        _downLineView.frame = CGRectMake(MaxX(_headImageView), MaxY(self.contentView) - ViewWidth(2), ScreenWidth() - MaxX(_headImageView), ViewWidth(2));
    }else{
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@dl?path=%@",NONGJIURL,_mode.headimage]] placeholderImage:[UIImage imageNamed:@"add"]];
        
        _headImageView.frame = CGRectMake(ViewFrameOriginX, ViewWidth(20), self.frame.size.height - ViewWidth(80), self.frame.size.height - ViewWidth(80));
        _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
        _headImageView.layer.masksToBounds = YES;
        _titleLable.text = [NSString stringWithFormat:@"机手姓名：%@",_mode.realName?_mode.realName:@"未知"];
        _titleLable.font = [UIFont systemFontOfSize:titleFontSize - 2];
        _titleLable.textColor = UIColorFromRGB(0x1784CA);
        _titleLable.frame = CGRectMake(MaxX(_headImageView) + ViewWidth(20), MinY(_headImageView), ScreenWidth() - MaxX(_headImageView) + ViewWidth(20) - ViewFrameOriginX, ViewWidth(36));
        
        
        _timeLable.text = [NSString stringWithFormat:@"作业品种：%@",_mode.serviceVri?_mode.serviceVri:@"未知"];
        _timeLable.font = [UIFont systemFontOfSize:titleFontSize - 2];
        _timeLable.frame = CGRectMake(MinX(_titleLable), MaxY(_titleLable),ScreenWidth() - MaxX(_headImageView) + ViewWidth(20) - ViewFrameOriginX, ViewWidth(36));
        
        _contentLable.text = [NSString stringWithFormat:@"作业类型：%@",_mode.serviceType?_mode.serviceType:@"未知"];;
        _contentLable.font = [UIFont systemFontOfSize:titleFontSize - 2];
        _contentLable.frame = CGRectMake(MinX(_titleLable), MaxY(_timeLable),ScreenWidth() - MaxX(_headImageView) + ViewWidth(20) - ViewFrameOriginX, ViewWidth(36));
        
        _contentImageView.frame = CGRectMake(ViewFrameOriginX, MaxY(_headImageView) + ViewWidth(20) ,ViewWidth(36), ViewWidth(36));
        
        _distanceLable.text = _mode.distance;
        
        _distanceLable.frame = CGRectMake(MaxX(_contentImageView) + ViewWidth(10), MinY(_contentImageView), ViewWidth(200), ViewWidth(36));
        
        _downLineView.frame = CGRectMake(0, MaxY(self.contentView) - ViewWidth(2), ScreenWidth(), ViewWidth(2));
    }
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
