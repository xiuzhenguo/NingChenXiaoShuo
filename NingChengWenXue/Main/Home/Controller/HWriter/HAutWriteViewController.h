//
//  HAutWriteViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/19.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeaveMessageModel.h"

@protocol AddLeaveMessageDelegate <NSObject>
@optional
- (void)addShupingModel:(LeaveMessageModel *)model;

@end

@interface HAutWriteViewController : UIViewController

@property (nonatomic, strong) NSString *authorId;;
@property (nonatomic, weak) id<AddLeaveMessageDelegate> delegate;

@end
