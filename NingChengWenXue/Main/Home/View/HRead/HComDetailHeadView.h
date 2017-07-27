//
//  HComDetailHeadView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ShuPingListModel.h"

@interface HComDetailHeadView : UIView

@property (nonatomic, strong) ShuPingListModel *viewModel;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UILabel *contentLab;

@property (nonatomic, strong) UILabel *fromLab;

@property (nonatomic, strong) UIButton *zanBtn;

@property (nonatomic, strong) UIButton *comBtn;

@property (nonatomic, strong) UILabel *lineLab;

@end
