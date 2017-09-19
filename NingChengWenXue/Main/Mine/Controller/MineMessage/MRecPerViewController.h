//
//  MRecPerViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectPersonDelegate <NSObject>
@optional
- (void)selectPersonDelegate:(NSString *)userID Name:(NSString *)userName;

@end

@interface MRecPerViewController : UIViewController

@property (nonatomic, weak) id<SelectPersonDelegate> delegate;

@end
