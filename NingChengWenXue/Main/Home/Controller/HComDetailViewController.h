//
//  HComDetailViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassTrendValueDelegate <NSObject>
@optional
- (void)passTrendValues:(NSInteger)row zancount:(NSInteger)count pinglun:(NSInteger)pinglun type:(NSInteger)type;

@end

@interface HComDetailViewController : UIViewController

@property (nonatomic, strong) NSString *secID;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, weak) id<PassTrendValueDelegate> delegate;
@property (nonatomic, assign) NSInteger type;

@end
