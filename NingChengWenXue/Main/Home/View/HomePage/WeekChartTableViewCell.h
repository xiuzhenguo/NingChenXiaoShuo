//
//  WeekChartTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/17.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BookListModel.h"
#import "BookKeysModel.h"
@interface WeekChartTableViewCell : UITableViewCell
@property(nonatomic,strong)BookListModel * viewModel;
@property(nonatomic,assign)CGFloat hetght;
@property (nonatomic, assign) NSInteger row;


@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *priceLab;

@property (nonatomic, strong) UILabel *formLab;

@property (nonatomic, strong) UILabel *signLab;

@property (nonatomic, strong) UILabel *VIPLab;

@property (nonatomic, strong) UILabel *typeLab;

@property (nonatomic, strong) UILabel *typeLable;

@property (nonatomic, strong) UILabel *nameLable;


@end
