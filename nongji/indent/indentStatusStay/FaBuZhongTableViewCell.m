//
//  FaBuZhongTableViewCell.m
//  nongji
//
//  Created by 七云 on 2017/4/17.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "FaBuZhongTableViewCell.h"
#define ViewFrameOriginX ViewWidth(50)
@interface FaBuZhongTableViewCell ()
{
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UIView *_downLineView;
    NSInteger _index;
}

@end

@implementation FaBuZhongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
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
    NSArray *titleArray = @[@"发布时间",@"姓名",@"作业时间",@"作业地点",@"作业面积",@"农作物",@"服务类型",@"理想报价",@"",@"已有一名机手接单",@"王二"];
    NSArray *contentArray =@[@"2016-05-27",@"李四",@"2016-06-27",@"江苏且前后第八eqweqw王企鹅和千万个千万v我讲方法很烦的，加速度",@"200亩",@"水稻",@"旋耕",@"80元、亩",@"描述:我很期待把公司发放的阿斯蒂芬阿斯蒂芬公司大发开发撒上菲儿数据发牢骚阿拉是符合大首付款发送廊坊市",@"",@"2016-06-27"];
    _titleLabel.text = titleArray[index>titleArray.count - 1?0:index];
    _contentLabel.text = contentArray[index>contentArray.count - 1?0:index];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self clearFrame];
    CGSize size = LabelSize(_titleLabel.text, titleFontSize - 2);
     _downLineView.frame = CGRectMake(ViewFrameOriginX,MaxY(self.contentView) - ViewWidth(1) , ScreenWidth() - ViewWidth(50), ViewWidth(1));
    if(_index == 4){
        _titleLabel.frame = CGRectMake(ViewFrameOriginX, ViewWidth(20), size.width, size.height);
        size = MoreLineLabelSize(_contentLabel.text, ScreenWidth() - MaxX(_titleLabel) - ViewFrameOriginX - ViewWidth(20), titleFontSize - 2);
        _contentLabel.frame = CGRectMake( ScreenWidth() - ViewFrameOriginX - size.width , MinY(_titleLabel), size.width, size.height);
    }else if(_index == 8){
        size = MoreLineLabelSize(_contentLabel.text, ScreenWidth()  - 2 * ViewFrameOriginX , titleFontSize - 2);
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.frame = CGRectMake(ViewFrameOriginX , ViewWidth(20), size.width, size.height);
    }else if(_index == 9){
        _titleLabel.frame = CGRectMake(ScreenWidth() / 2 - size.width / 2, ViewWidth(44) - size.height / 2 , size.width, size.height);
    }else if(_index > 9){
        _titleLabel.frame = CGRectMake(ViewFrameOriginX, ViewWidth(44) - size.height / 2 , size.width, size.height);
        size = LabelSize(_contentLabel.text, titleFontSize - 2);
        _contentLabel.frame = CGRectMake(ScreenWidth() - ViewFrameOriginX - size.width - ViewWidth(34), ViewWidth(44) - size.height / 2 , size.width, size.height);
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_right"]];
        img.frame = CGRectMake(ScreenWidth() - ViewWidth(63), MinY(_titleLabel), ViewWidth(13), ViewWidth(30));
        [self.contentView addSubview:img];
    }else{
        _titleLabel.frame = CGRectMake(ViewFrameOriginX, self.contentView.center.y - size.height/2, size.width, size.height);
        
        size = MoreLineLabelSize(_contentLabel.text, ScreenWidth() - MaxX(_titleLabel) - ViewFrameOriginX - ViewWidth(20), titleFontSize - 2);
        _contentLabel.frame = CGRectMake(  ScreenWidth() - ViewFrameOriginX - size.width , MinY(_titleLabel), size.width, size.height);
    }
    
    
   
    
}

-(void)clearFrame{
    _titleLabel.frame = CGRectMake(0, 0, 0, 0);
    _contentLabel.frame = CGRectMake(0, 0, 0, 0);
}


@end
