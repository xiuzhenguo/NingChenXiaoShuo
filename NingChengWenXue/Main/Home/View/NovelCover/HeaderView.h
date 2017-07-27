//
//  HeaderView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/20.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NovelDatailModel.h"

@interface HeaderView : UIView

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) NovelDatailModel *model;

@property(nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *typeLab;
@property (nonatomic, strong) UILabel *readLab;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *writorLab;
@property (nonatomic, strong) UILabel *rankLab;
@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UILabel *dainjiLab;
@property (nonatomic, strong) UILabel *shoucangLab;
@property (nonatomic, strong) UILabel *guanzhuLab;
@property (nonatomic, strong) UILabel *fenxiangLab;

@end
