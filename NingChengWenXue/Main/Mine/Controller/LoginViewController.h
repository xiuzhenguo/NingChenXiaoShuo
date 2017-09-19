//
//  LoginViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/14.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate <NSObject>
@optional
- (void)logindelegate:(NSString *)userId;

@end

@interface LoginViewController : UIViewController

@property (nonatomic, weak) id<LoginDelegate> delegate;

@end
