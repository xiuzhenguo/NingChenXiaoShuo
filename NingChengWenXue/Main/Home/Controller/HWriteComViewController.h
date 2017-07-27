//
//  HWriteComViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShuPingListModel.h"

@protocol AddShuPingDelegate <NSObject>
@optional
- (void)addShupingModel:(ShuPingListModel *)model;

@end

@interface HWriteComViewController : UIViewController

@property (nonatomic, strong) NSString *bookID;
@property (nonatomic, strong) NSString *secID;
@property (nonatomic, weak) id<AddShuPingDelegate> delegate;

@end
