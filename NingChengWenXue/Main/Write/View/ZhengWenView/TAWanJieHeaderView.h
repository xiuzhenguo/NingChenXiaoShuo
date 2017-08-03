//
//  TAWanJieHeaderView.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhengWenListModel.h"

@interface TAWanJieHeaderView : UIView

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *typeLab;
@property (nonatomic, strong) UIImageView *typeImg;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *lineLab;
@property (nonatomic, strong) UILabel *guizeLab;
@property (nonatomic, strong) UIImageView *moreImg;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIImageView *workImg;
@property (nonatomic, strong) UILabel *workLab;
@property (nonatomic, strong) UIView *oneView;
@property (nonatomic, strong) UIView *twoView;


@property (nonatomic, strong) ZhengWenListModel *model;
@property (nonatomic, assign) CGFloat height;

@end
