//
//  IssueTableViewCell.m
//  nongji
//
//  Created by tobo on 17/4/21.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "IssueTableViewCell.h"
#define ViewFrameOriginX ViewWidth(30)

@interface IssueTableViewCell ()<UITextFieldDelegate>
{
    UIView *_downLineView;
    UIImageView *_rightImgView;
    UILabel *_rightLabel;
}
@end

@implementation IssueTableViewCell

- (void)addSubviewsWithindexRow:(NSInteger)indexRow{
    _titleLable = [UILabel new];
    _titleLable.textColor = UIColorFromRGB(0x666666);
    _titleLable.font = [UIFont systemFontOfSize:titleFontSize - 2];
    [self.contentView addSubview:_titleLable];
    
    _textField = [UITextField new];
    _textField.delegate = self;
    _textField.tag = 100+indexRow;
    _textField.textColor = UIColorFromRGB(0x3333333);
    _textField.font = [UIFont systemFontOfSize:titleFontSize - 2];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:_textField];
    if (indexRow == 1 || indexRow == 4 || indexRow == 5 || indexRow == 6) {
        _rightImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_right"]];
        _rightImgView.frame = CGRectMake(ScreenWidth() - ViewFrameOriginX - ViewWidth(13), ViewWidth(20), ViewWidth(13), ViewWidth(30));
        [self.contentView addSubview:_rightImgView];
    }
    
    _downLineView = [[UIView alloc] init];
    
    if (indexRow ==0 || indexRow == 7) {
        _downLineView.backgroundColor = UIColorFromRGB(0xcccccc);
        _downLineView.frame = CGRectMake(ViewFrameOriginX - ViewWidth(20), MaxY(self.contentView) - ViewWidth(2), ScreenWidth() - ViewFrameOriginX, ViewWidth(2));
    }else{
        _downLineView.backgroundColor = LINECOLOR;
        _downLineView.frame = CGRectMake(ViewFrameOriginX, MaxY(self.contentView) - ViewWidth(1), ScreenWidth() - ViewFrameOriginX, ViewWidth(1));
    }
  
  
    [self.contentView addSubview:_downLineView];
}

- (void)configureData:(NSArray*)titleLableArray  :(NSArray *)subTitleArray indexRow:(NSInteger)indexRow{
    
    
    _titleLable.text = titleLableArray[indexRow];
    
    switch (indexRow) {
        case 0:
        {
            _textField.enabled = NO;
            _titleLable.font  = [UIFont boldSystemFontOfSize:titleFontSize + 2];
        }
            break;
        case 1:
        {
            _textField.text = @"江苏南京市江宁区";
            _textField.enabled = NO;
        }
            break;
        case 2:
        {
            _textField.placeholder = @"请填写具体乡镇地址";
        }
            break;
        case 3:
        {
            _textField.placeholder = @"请输入耕地面积";
        }
            break;
        case 4:
        {
            _textField.enabled = NO;
            _textField.placeholder = @"请选择农作物";
        }
            break;
        case 5:
        {
            _textField.enabled = NO;
            _textField.placeholder = @"请输入需求开始时间";
        }
            break;
        case 6:
        {
            _textField.enabled = NO;
            _textField.placeholder = @"请选择服务类型";
        }
            break;
        case 7:
        {
            _textField.enabled = NO;
            _titleLable.font  = [UIFont boldSystemFontOfSize:titleFontSize];
        }
            break;
        case 8:
        {
            _textField.placeholder = @"请输入理想报价";
        }
            break;
        default:{
            _textField.enabled = NO;
        }
            break;
    }
    
    CGSize size = LabelSize(_titleLable.text, titleFontSize );
    _titleLable.frame = CGRectMake(ViewFrameOriginX, ViewWidth(20), size.width + ViewWidth(20), size.height);
    
    size = LabelSize(@"请填写具体乡镇地址浏览", titleFontSize);
    _textField.frame = CGRectMake(ScreenWidth() - ViewFrameOriginX * 2 - size.width , ViewWidth(20), size.width, size.height);
    
      NSString *rightLableText = indexRow==3?@"(亩)":@"(元/亩)";
    if (indexRow == 3 || indexRow == 8) {
        _rightLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x333333) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:rightLableText];
        CGSize size = LabelSize(_rightLabel.text, titleFontSize );
        _rightLabel.frame = CGRectMake(ScreenWidth() - ViewFrameOriginX - size.width, ViewWidth(20), size.width, size.height);
        [self.contentView addSubview:_rightLabel];
        _textField.frame = CGRectMake(MinX(_textField) , ViewWidth(20), viewWidth(_textField) - size.width, size.height);
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
