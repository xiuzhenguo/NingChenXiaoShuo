//
//  HLitDetailHeaderView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnionDetailModel.h"

@interface HLitDetailHeaderView : UIView

@property(nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIButton *joinBtn;
// 测试
@property (nonatomic, strong) NSString *conStr;


@property (nonatomic, strong) UILabel *schNameLable;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *rankLab;
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UnionDetailModel *model;


@end
