//
//  IndentTableViewCell.m
//  nongji
//
//  Created by tobo on 17/4/20.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "IndentTableViewCell.h"

#define ViewFrameOriginX ViewWidth(30)

@interface IndentTableViewCell ()
{
    UILabel *_addressLabel;
    UILabel *_nameLabel;
    UILabel *_phoneLabel;
    UILabel *_cropsLabel;
    UILabel *_areaLabel;
    
    UIView *_downLineView;
    
    UILabel *_label1;
    UILabel *_label2;
    UILabel *_label3;
    UILabel *_label4;
    UILabel *_label5;
    UILabel *_label6;
    UIImageView *_rightImgView;
    
}
@end

@implementation IndentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]) {
        [self createCustomViewS];
    }
    return self;
}

- (void)createCustomViewS{
    _label1 = [MyTools lableWithtextColor:UIColorFromRGB(0x666666) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"姓  名 :"];
    [self.contentView addSubview:_label1];
    
    
     _nameLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x666666) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"李四"];
    [self.contentView addSubview:_nameLabel];
    
    _label2 = [MyTools lableWithtextColor:UIColorFromRGB(0x666666) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"电  话 :"];
    [self.contentView addSubview:_label2];
    
    _phoneLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x666666) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"13972991221"];
    [self.contentView addSubview:_phoneLabel];
    
    
    _label3 = [MyTools lableWithtextColor:UIColorFromRGB(0xffffff) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"3"];
    _label3.textAlignment = NSTextAlignmentCenter;
    _label3.backgroundColor = [UIColor blackColor];
    _label3.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_label3];
    
    _label4 = [MyTools lableWithtextColor:UIColorFromRGB(0x666666) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"农作物 :"];
    [self.contentView addSubview:_label4];
    
    _cropsLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x666666) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"棉花"];
    [self.contentView addSubview:_cropsLabel];
    
   _label5 = [MyTools lableWithtextColor:UIColorFromRGB(0x666666) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"面  积 :"];
    [self.contentView addSubview:_label5];
    
    _areaLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x666666) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"1223亩"];
    [self.contentView addSubview:_areaLabel];
    
    
    _label6 = [MyTools lableWithtextColor:UIColorFromRGB(0x666666) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"地  址 :"];
    [self.contentView addSubview:_label6];
    
    _addressLabel = [MyTools lableWithtextColor:UIColorFromRGB(0x666666) textFont:[UIFont systemFontOfSize:titleFontSize - 2] inSize:CGSizeZero withText:@"江苏省宿迁市泗洪县"];
    [self.contentView addSubview:_addressLabel];
    
    _rightImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_right"] ];
    [self.contentView addSubview:_rightImgView];
    _downLineView = [[UIView alloc] init];
    _downLineView.backgroundColor = LINECOLOR;
    [self.contentView addSubview:_downLineView];
}

-(void)layoutSubviews{
    [self clearFrame];
    [super layoutSubviews];
    
    CGSize size = LabelSize(_label1.text, titleFontSize - 2);
    _label1.frame = CGRectMake(ViewFrameOriginX, ViewWidth(20), size.width, size.height);
    
    size = LabelSize(_nameLabel.text, titleFontSize - 2);
    _nameLabel.frame = CGRectMake(MaxX(_label1) +ViewWidth(20), ViewWidth(20), size.width, size.height);
    
    size = LabelSize(_label3.text, titleFontSize - 2);
    _label3.frame = CGRectMake(ScreenWidth() - ViewFrameOriginX - size.width, ViewWidth(20), size.width >size.height?size.width:size.height , size.height);
    
    size = LabelSize(_phoneLabel.text, titleFontSize - 2);
    _phoneLabel.frame = CGRectMake(MinX(_label3) - size.width - ViewWidth(20), ViewWidth(20), size.width, size.height);
    
    size = LabelSize(_label2.text, titleFontSize - 2);
    _label2.frame = CGRectMake(MinX(_phoneLabel) - size.width - ViewWidth(20), ViewWidth(20), size.width , size.height);
    
    size = LabelSize(_label4.text, titleFontSize - 2);
    _label4.frame = CGRectMake(ViewFrameOriginX, MaxY(_phoneLabel) + ViewWidth(20), size.width, size.height);
    
    size = LabelSize(_cropsLabel.text, titleFontSize - 2);
    _cropsLabel.frame = CGRectMake(MaxX(_label4) + ViewWidth(20), MaxY(_phoneLabel) + ViewWidth(20), size.width, size.height);
    
    size = LabelSize(_label5.text, titleFontSize - 2);
    _label5.frame = CGRectMake(MinX(_label2), MaxY(_phoneLabel) + ViewWidth(20),size.width , size.height);
    
    size = LabelSize(_areaLabel.text, titleFontSize - 2);
    _areaLabel.frame = CGRectMake(MaxX(_label5) +ViewWidth(20), MaxY(_phoneLabel) + ViewWidth(20), size.width, size.height);
    
    if (_status == IndentStatusStay) {
    size = LabelSize(_label6.text, titleFontSize - 2);
    _label6.frame = CGRectMake(ViewFrameOriginX, MaxY(_areaLabel) + ViewWidth(20), size.width, size.height);
    size = LabelSize(_addressLabel.text, titleFontSize - 2);
    _addressLabel.frame = CGRectMake(MaxX(_label6) +ViewWidth(20), MaxY(_areaLabel) + ViewWidth(20), size.width, size.height);
    _rightImgView.frame = CGRectMake(MinX(_label3), MinY(_addressLabel), ViewWidth(13), ViewWidth(30));
    }
    _downLineView.frame = CGRectMake(ViewFrameOriginX,  MaxY(self.contentView) - ViewWidth(1), ScreenWidth() - ViewFrameOriginX,ViewWidth(1));
}


- (void)setStatus:(IndentStatus)status{
    _status = status;
    switch (_status) {
        case IndentStatusStay:
        {
            _label1.text = @"姓  名:";
            _label2.text = @"电  话:";
            _label4.text = @"农作物:";
            _label5.text = @"面  积:";
        }
            break;
        case IndentStatusWorking:
        {
            _label1.text = @"操作手:";
            _label2.text = @"电  话:";
            _label4.text = @"机手报价:";
            _label5.text = @"完成面积:";
        }
            break;
        case IndentStatusFinish:
        {
            _label1.text = @"操作手:";
            _label2.text = @"电  话:";
            _label4.text = @"完成时间:";
            _label5.text = @"完成面积:";
        }
            break;
        default:
            break;
    }
}

- (void)clearFrame{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectMake(0, 0, 0, 0);
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
/*
 //    cell.backgroundColor = [UIColor grayColor];


 */
