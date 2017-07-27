//
//  HBRightTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/1.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BillboardModel.h"

@interface HBRightTableViewCell : UITableViewCell

@property (nonatomic, strong) BillboardModel *viewModel;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *signLab;

@property (nonatomic, strong) UILabel *authorLab;

@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) UILabel *moneyLab;

@property (nonatomic, strong) UILabel *typeLab;

@property (nonatomic, strong) UILabel *lineLab;

@property (nonatomic, strong) UILabel *longLab;

@end
