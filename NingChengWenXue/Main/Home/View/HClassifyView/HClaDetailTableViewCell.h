//
//  HClaDetailTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BookKeysModel.h"

@interface HClaDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) BookKeysModel *viewModel;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *authorLab;

@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) UILabel *longLab;

@property (nonatomic, strong) UILabel *signLab;

@property (nonatomic, strong) UILabel *lineLab;

@end
