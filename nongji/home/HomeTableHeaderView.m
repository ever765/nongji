//
//  HomeTableHeaderView.m
//  nongji
//
//  Created by tobo on 17/4/24.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import "HomeTableHeaderView.h"
#import "SDCycleScrollView.h"
#import "HomeModel.h"
@interface HomeTableHeaderView ()<SDCycleScrollViewDelegate>

@end
@implementation HomeTableHeaderView



- (void)setDataScoure:(HomeModel *) model{
    
    if (model) {
        NSMutableArray *imagesURLStrings = [NSMutableArray new];
        for (SliderModel *mode in model.slider) {
            [imagesURLStrings addObject:[NSString stringWithFormat:@"%@dl?path=%@",NONGJIURL,mode.path]];
        }
        // 网络加载 --- 创建带标题的图片轮播器
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth(), ViewWidth(300)) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [self addSubview: cycleScrollView];
        
        //         --- 模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView.imageURLStringsGroup = imagesURLStrings;
        });
        
        NSArray *titleArray = @[@"农户入驻",@"机手入驻",@"近期接单"];
        NSArray *array = @[model.farmerNumber,model.driverNumber,model.completeOrderNumber];
        for (NSInteger i = 0 ; i < 3 ; i++) {
            UILabel *label = [MyTools lableWithtextColor:UIColorFromRGB(0x1784CA) textFont:[UIFont systemFontOfSize:titleFontSize] inSize:CGSizeZero withText:titleArray[i]];
            CGSize size = LabelSize(label.text, titleFontSize);
            label.frame = CGRectMake(0, MaxY(cycleScrollView) + ViewWidth(20), size.width, size.height);
            label.center = CGPointMake(ScreenWidth() / 6 * (1 + i * 2), label.center.y);
            [self addSubview:label];
            
            UILabel *label1 = [MyTools lableWithtextColor:UIColorFromRGB(0x888888) textFont:[UIFont systemFontOfSize:titleFontSize - 4] inSize:CGSizeZero withText:[NSString stringWithFormat:@"%@%@",array[i],i==2?@"笔":@"位"]];
            size = LabelSize(label1.text, titleFontSize - 4 );
            label1.frame = CGRectMake(0, MaxY(label) + ViewWidth(20), size.width, size.height);
            label1.center = CGPointMake(ScreenWidth() / 6 * (1 + i * 2), label1.center.y);
            [self addSubview:label1];
        }

    }
    
   }


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
