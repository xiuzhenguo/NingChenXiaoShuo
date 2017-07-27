//
//  HNewestTypeView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNewestTypeView : UIView

@property (nonatomic, strong) UIImageView *backImgView;

@property (nonatomic, strong) UIButton *newestBtn;

@property (nonatomic, strong) UIButton *hostBtn;

-(void)viewShowAnimation:(BOOL)animation;
-(void)viewHiddenAnimation:(BOOL)animation;

@end
