//
//  HSecDetailViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/21.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassSecValueDelegate <NSObject>
@optional
- (void)passTrendValues:(NSInteger)row zancount:(NSInteger)count pinglun:(NSInteger)pinglun type:(NSInteger)type;

@end

@interface HSecDetailViewController : UIViewController

@property (nonatomic, strong) NSString *secID;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, weak) id<PassSecValueDelegate> delegate;
@property (nonatomic, assign) NSInteger type;

@end
