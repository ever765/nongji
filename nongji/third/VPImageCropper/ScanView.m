//
//  ScanView.m
//  CrameraDemo
//
//  Created by GoodRobin on 16/9/19.
//  Copyright © 2016年 GoodRobin. All rights reserved.
//

#import "ScanView.h"



#define CONTROLBAR_WIDTH   217.f/[UIScreen mainScreen].scale
@implementation ScanView {
        
//    UIImageView *_shadowView;//
//    
    
    UIView *_scanControlBar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
   
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    

    
    if (!_hintLabel) {
        [self createHintLabelB];
    }
 
}


- (void)createHintLabelB {
    
    _hintLabelB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44)];
    _hintLabelB.center = CGPointMake(self.center.x, CGRectGetMaxY(self.frame) - 100);
    _hintLabelB.backgroundColor = [UIColor clearColor];
    _hintLabelB.textAlignment = NSTextAlignmentCenter;
    _hintLabelB.textColor = [UIColor whiteColor];
    _hintLabelB.font = [UIFont systemFontOfSize:20 weight:0.5];
    _hintLabelB.text = @"将身份证对边框，即可拍照上传";
    [self addSubview:_hintLabelB];
}

- (void)scanAction {
    
    if (self.scanBolck) {
        self.scanBolck(YES);
    }
}

- (void)scanCancleAction {
    
    if (self.scanBolck) {
        self.scanBolck(NO);
    }
}



- (void)drawRect:(CGRect)rect {
    
    //整个二维码扫描界面的颜色
    CGSize screenSize =[UIScreen mainScreen].bounds.size;
    CGRect screenDrawRect =CGRectMake(0, 0, screenSize.width,screenSize.height);
    
    //中间清空的矩形框
    CGRect clearDrawRect = CGRectMake(screenDrawRect.size.width / 2 - self.transparentArea.width / 2,
                                     // screenDrawRect.size.height / 2 - self.transparentArea.height / 2,
                                      100,
                                      self.transparentArea.width,self.transparentArea.height);
    _scanRect = clearDrawRect;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self addScreenFillRect:ctx rect:screenDrawRect];
    
    [self addCenterClearRect:ctx rect:clearDrawRect];
    
    [self addWhiteRect:ctx rect:clearDrawRect];
    
    [self addCornerLineWithContext:ctx rect:clearDrawRect];
}

- (void)addScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextSetRGBFillColor(ctx, 40 / 255.0,40 / 255.0,40 / 255.0,0.5);
    CGContextFillRect(ctx, rect);   //draw the transparent layer
}

- (void)addCenterClearRect :(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextClearRect(ctx, rect);  //clear the center rect  of the layer
}

- (void)addWhiteRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextStrokeRect(ctx, rect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 0.8);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

- (void)addCornerLineWithContext:(CGContextRef)ctx rect:(CGRect)rect{
    
    //画四个边角
    CGContextSetLineWidth(ctx, 2);
    CGContextSetRGBStrokeColor(ctx, 31 /255.0, 99/255.0, 234/255.0, 1);//蓝色
    
    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x-0.7, rect.origin.y),
        CGPointMake(rect.origin.x-0.7 , rect.origin.y + 15)
    };
    
    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x, rect.origin.y -0.7),CGPointMake(rect.origin.x + 15, rect.origin.y-0.7)};
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];
    
    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x- 0.7, rect.origin.y + rect.size.height - 15),CGPointMake(rect.origin.x -0.7,rect.origin.y + rect.size.height)};
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x , rect.origin.y + rect.size.height + 0.7) ,CGPointMake(rect.origin.x-0.7 +15, rect.origin.y + rect.size.height + 0.7)};
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];
    
    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - 15, rect.origin.y-0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y -0.7 )};
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x+ rect.size.width+0.7, rect.origin.y),CGPointMake(rect.origin.x + rect.size.width+0.7,rect.origin.y + 15 -0.7 )};
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];
    
    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x+ rect.size.width +0.7 , rect.origin.y+rect.size.height+ -15),CGPointMake(rect.origin.x+0.7 + rect.size.width,rect.origin.y +rect.size.height )};
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - 15 , rect.origin.y + rect.size.height+0.7),CGPointMake(rect.origin.x + rect.size.width,rect.origin.y + rect.size.height + 0.7 )};
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    CGContextStrokePath(ctx);

}


- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx {
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
}


@end
