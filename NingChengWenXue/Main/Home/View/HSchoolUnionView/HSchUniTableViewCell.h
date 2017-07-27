//
//  HSchUniTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/7.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UnionHomeModel.h"

@interface HSchUniTableViewCell : UITableViewCell

@property(nonatomic, strong) UnionHomeModel *viewModel;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *schNameLab;

@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) UILabel *perNumLab;

@property (nonatomic, strong) UILabel *lineLab;

@end
