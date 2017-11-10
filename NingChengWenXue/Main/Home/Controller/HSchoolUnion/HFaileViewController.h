//
//  HFaileViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SchoolUnionFaildReasonDelegate <NSObject>
@optional
- (void)SchoolUnionFaildReason;

@end

@interface HFaileViewController : UIViewController

@property (nonatomic, weak) id<SchoolUnionFaildReasonDelegate> delegate;

@end
