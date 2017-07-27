//
//  HAutherHeadView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/22.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriterDetailModel.h"

@interface HAutherHeadView : UIView

@property (nonatomic, strong) WriterDetailModel *model;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *IDLab;

@property (nonatomic, strong) UILabel *rankLab;

@property (nonatomic, strong) UILabel *martialLab;

@property (nonatomic, strong) UILabel *personLab;

@property (nonatomic, strong) UILabel *vigorousLab;

@property (nonatomic, strong) UIImageView *cardImgView;

@property (nonatomic, strong) UIImageView *orderImgView;

@property (nonatomic, strong) UIButton *cardBtn;

@property (nonatomic, strong) UIButton *medalBtn;


@end
