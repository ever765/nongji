//
//  SIActionsheet.m
//  SIAPP
//
//  Created by Leon on 16/5/16.
//  Copyright © 2016年 localadmin. All rights reserved.
//

#import "SIActionSheet.h"
#import "AppDelegate.h"
#define MARGIN 12
#define BOTTOM_MARGIN 10
#define BTN_HEIGHT 42
#define  kSettingSectionFont [UIFont systemFontOfSize:titleFontSize]
@interface SIActionSheet ()

@property (nonatomic, strong) UIButton* cancelBtn;
@property (nonatomic, strong) UIView* btnsView;

@end

@implementation SIActionSheet

-(instancetype)initWithCancelButonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles delegate:(id<SIActionSheetDelegate>)delegate{

    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        self.btnsView = [[UIView alloc] init];
        self.btnsView.backgroundColor = [UIColor whiteColor];
        CGFloat btnsViewH = BTN_HEIGHT * otherButtonTitles.count + 1 * (otherButtonTitles.count - 1);
        CGFloat btnsViewY = ScreenHeight() - BTN_HEIGHT - BOTTOM_MARGIN - MARGIN - btnsViewH;
        self.btnsView.frame = CGRectMake(MARGIN, btnsViewY, ScreenWidth() - MARGIN * 2, btnsViewH);
        self.btnsView.layer.cornerRadius = 3;
        self.btnsView.clipsToBounds = YES;
        [self addSubview:self.btnsView];
        
        self.delegate = delegate;
        [self initCancelBtnWithTitle:cancelButtonTitle];
        [self initOtherBtnWithTitles:otherButtonTitles];
    }
    return self;
}

-(void)initCancelBtnWithTitle:(NSString*)title{

    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(MARGIN, ScreenHeight() - BOTTOM_MARGIN - BTN_HEIGHT, ScreenWidth() - MARGIN * 2, BTN_HEIGHT);
    _cancelBtn.layer.cornerRadius = 3;
    [_cancelBtn setTitle:title forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:UIColorFromRGB(0x35c7fa) forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = kSettingSectionFont;
    _cancelBtn.backgroundColor = [UIColor whiteColor];
    [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelBtn];
}

-(void)cancelBtnAction{
    
    [self removeFromSuperview];
}

-(void)initOtherBtnWithTitles:(NSArray*)titles{

    for (int i = 0; i < titles.count; i++) {
        NSString* title = titles[i];
        UIButton* otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        otherBtn.tag = i;
        [otherBtn setTitle:title forState:UIControlStateNormal];
        [otherBtn setTitleColor:UIColorFromRGB(0x35c7fa) forState:UIControlStateNormal];
        otherBtn.titleLabel.font = kSettingSectionFont;
        otherBtn.backgroundColor = [UIColor whiteColor];
        otherBtn.frame = CGRectMake(0, (CGRectGetHeight(self.btnsView.frame) - BTN_HEIGHT - (BTN_HEIGHT + 1) * i), CGRectGetWidth(self.btnsView.frame), BTN_HEIGHT);
        [otherBtn addTarget:self action:@selector(otherBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnsView addSubview:otherBtn];
        if (titles.count > 1 && i < titles.count -1) {
            UILabel* line = [[UILabel alloc] init];
            line.backgroundColor = UIColorFromRGB(0xe5e5e5);
            line.frame = CGRectMake(0, CGRectGetMinY(otherBtn.frame) - 1, CGRectGetWidth(self.btnsView.frame), 1);
            [self.btnsView addSubview:line];
        }
    }
}

-(void)otherBtnAction:(UIButton*)sender{
    
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:withTitle:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:sender.tag withTitle:sender.titleLabel.text];
    }
    [self removeFromSuperview];
}

-(void)show{

    AppDelegate* appdeleagte = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appdeleagte.window addSubview:self];
}

@end
