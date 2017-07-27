//
//  HBRTyrantTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/1.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BillboardModel.h"

@interface HBRTyrantTableViewCell : UITableViewCell

@property (nonatomic, strong) BillboardModel *viewModel;

@property (nonatomic, strong) BillboardModel *model;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *moneyLab;

@property (nonatomic, strong) UILabel *glowLab;

@property (nonatomic, strong) UILabel *lineLab;

@end
