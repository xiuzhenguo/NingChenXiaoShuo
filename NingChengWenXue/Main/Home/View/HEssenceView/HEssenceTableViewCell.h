//
//  HEssenceTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/3.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExceedListModel.h"
#import "BookKeysModel.h"

@interface HEssenceTableViewCell : UITableViewCell

@property(nonatomic, strong) ExceedListModel *viewModel;


@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *authorLab;

@property (nonatomic, strong) UIButton *collecBtn;

@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) UILabel *signLab;

@property (nonatomic, strong) UILabel *VIPLab;

@property (nonatomic, strong) UILabel *typeLab;

@property (nonatomic, strong) UILabel *typeLable;

@property (nonatomic, strong) UILabel *lineLab;


@end
