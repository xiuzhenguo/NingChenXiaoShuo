//
//  HRBoomMenuView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/24.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSYMenuViewDelegate;
@interface HRBoomMenuView : UIView
@property (nonatomic,assign) BOOL state; //(0--未保存过，1-－保存过)
@property (nonatomic,weak) id<LSYMenuViewDelegate>delegate;

@property (nonatomic,strong) UIButton *giftBtn;

@property (nonatomic,strong) UIButton *commentBtn;

@property (nonatomic, strong) UIButton *collectBtn;

@property (nonatomic, strong) UIButton *shareBtn;

@end

