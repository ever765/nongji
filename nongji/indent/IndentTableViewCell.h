//
//  IndentTableViewCell.h
//  nongji
//
//  Created by tobo on 17/4/20.
//  Copyright © 2017年 WDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    IndentStatusStay,
    IndentStatusWorking,
    IndentStatusFinish,
} IndentStatus;

@interface IndentTableViewCell : UITableViewCell

@property (nonatomic, assign)IndentStatus status;

@end
