//
//  HAutWordDetailViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/31.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassLeaveMessageValueDelegate <NSObject>
@optional
- (void)passLeaveMessageValues:(NSInteger)row pinglun:(NSInteger)pinglun;

@end

@interface HAutWordDetailViewController : UIViewController

@property (nonatomic, strong) NSString *leaveId;
@property (nonatomic, weak) id<PassLeaveMessageValueDelegate> delegate;
@property (nonatomic, assign) NSInteger row;

@end
