//
//  InformationTableViewCell.m
//  nongji
//
//  Created by tobo on 17/5/3.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "InformationTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation InformationTableViewCell

UIView *_downLineView;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addSubviewsWithindexRow:(NSIndexPath *)indexPath{
    _titleLable = [UILabel new];
    _titleLable.textColor = UIColorFromRGB(0x666666);
    _titleLable.font = [UIFont systemFontOfSize:titleFontSize - 2];
    [self.contentView addSubview:_titleLable];
    
    _textField = [UITextField new];
    _textField.textColor = UIColorFromRGB(0x3333333);
    _textField.textAlignment = NSTextAlignmentRight;
    _textField.font = [UIFont systemFontOfSize:titleFontSize - 2];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:_textField];
    
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.image = [UIImage imageNamed:@"ic_action_integral"];
    [self.contentView addSubview:_headerImageView];
    
    _downLineView = [[UIView alloc] init];
    _downLineView.backgroundColor = LINECOLOR;
    [self.contentView addSubview:_downLineView];
}

- (void)configureData:(NSArray*)titleLableArray  :(NSArray *)subTitleArray indexRow:(NSInteger)indexRow{
    
    
    _titleLable.text = titleLableArray[indexRow];
    
    switch (indexRow) {
        case 0:
        {
             _textField.enabled = NO;
            _headerImageView.image = [UIImage imageNamed:@"1"];
             [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@dl?path=%@",NONGJIURL,subTitleArray[0]]]];
            
        }
            break;
        case 1:
        {
            _textField.text =[subTitleArray[indexRow] isEqual:[NSNull null]]?@"未知":subTitleArray[indexRow];
        }
            break;
        case 2:
        {
            _textField.enabled = NO;
            _textField.text = [subTitleArray[indexRow] isEqual:[NSNull null]]?@"男":subTitleArray[indexRow];
        }
            break;
        case 3:
        {
            NSDate *currentDate = [NSDate date];//获取当前时间，日期
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSString *dateString = [dateFormatter stringFromDate:currentDate];
            _textField.text = [subTitleArray[indexRow] isEqual:[NSNull null]]?dateString:subTitleArray[indexRow];
            _textField.enabled = NO;
        }
            break;
        case 4:
        {
            _textField.enabled = NO;
            _textField.text = subTitleArray[indexRow];
        }
            break;
        default:{
           
        }
            break;
    }
    CGSize size = LabelSize(_titleLable.text, titleFontSize);
    _titleLable.frame = CGRectMake(ViewWidth(50),ViewWidth(44) - size.height/2, size.width, size.height);
    if (indexRow == 0) {
        _titleLable.frame = CGRectMake(ViewWidth(50),ViewWidth(60) - size.height/2, size.width, size.height);
        _headerImageView.frame = CGRectMake(ScreenWidth() - ViewWidth(190),ViewWidth(10), ViewWidth(100), ViewWidth(100));
        _headerImageView.layer.cornerRadius = ViewWidth(50);
        _headerImageView.layer.masksToBounds = YES;
    }else{
       size = LabelSize(@"我晚上对方很不舒服", titleFontSize);
        _textField.frame = CGRectMake(ScreenWidth() - ViewWidth(70) - size.width, MinY(_titleLable), size.width, size.height);
    }
}




- (void)layoutSubviews{
    [super layoutSubviews];
     _downLineView.frame = CGRectMake(0,MaxY(self.contentView) - ViewWidth(1) , ScreenWidth(), ViewWidth(1));
}


@end
