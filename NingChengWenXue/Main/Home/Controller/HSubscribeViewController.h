//
//  HSubscribeViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/22.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectReadTypeDelegate <NSObject>
@optional
- (void)selectReadtype:(NSString *)typeId;

@end

@interface HSubscribeViewController : UIViewController

@end
