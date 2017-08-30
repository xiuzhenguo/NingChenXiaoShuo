//
//  HReadMenuView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/24.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYTopMenuView.h"
#import "HRBoomMenuView.h"
@class HReadMenuView;

@protocol LSYMenuViewDelegate <NSObject>
@optional

-(void)menuViewMark;

@end

@interface HReadMenuView : UIView
@property (nonatomic,weak) id<LSYMenuViewDelegate> delegate;
@property (nonatomic,strong) LSYTopMenuView *topView;
@property (nonatomic, strong) HRBoomMenuView *boomView;

-(void)showAnimation:(BOOL)animation;
-(void)hiddenAnimation:(BOOL)animation;

@end
