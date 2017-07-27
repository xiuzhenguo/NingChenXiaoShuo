//
//  HSecWriteViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/21.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShuPingListModel.h"

@protocol AddSecShuPingDelegate <NSObject>
@optional
- (void)addShupingModel:(ShuPingListModel *)model;

@end

@interface HSecWriteViewController : UIViewController

@property (nonatomic, strong) NSString *bookID;
@property (nonatomic, strong) NSString *secID;
@property (nonatomic, assign) NSInteger SectionIndex;
@property (nonatomic, strong) NSString *SectionName;
@property (nonatomic, weak) id<AddSecShuPingDelegate> delegate;


@end
