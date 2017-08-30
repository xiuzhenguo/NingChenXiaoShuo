//
//  TARuleTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AwardsZhengWenModel.h"

@interface TARuleTableViewCell : UITableViewCell

@property (nonatomic, strong) AwardsZhengWenModel *viewModel;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UILabel *shuLab;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *lineLab;
@property (nonatomic, strong) UILabel *lineView;

@end
