//
//  SIActionsheet.h
//  SIAPP
//
//  Created by Leon on 16/5/16.
//  Copyright © 2016年 localadmin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SIActionSheet;

@protocol SIActionSheetDelegate <NSObject>
@optional
- (void)actionSheet:(SIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex withTitle:(NSString*)title;

@end

@interface SIActionSheet : UIView

@property (nonatomic, weak) id<SIActionSheetDelegate>delegate;

-(instancetype)initWithCancelButonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSArray*)otherButtonTitles delegate:(id<SIActionSheetDelegate>)delegate;

-(void)show;

@end
