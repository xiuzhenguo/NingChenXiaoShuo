//
//  TARuleHeadView.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhengWenListModel.h"

@interface TARuleHeadView : UIView

@property (nonatomic, strong) ZhengWenListModel *viewModel;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *typeLab;
@property (nonatomic, strong) UIImageView *typeImg;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *guizeLab;
@property (nonatomic, strong) UILabel *lineLab;

@end
