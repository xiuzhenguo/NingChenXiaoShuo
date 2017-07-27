//
//  HLitDetMidTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnionDetailModel.h"
#import "UserItemModel.h"

@interface HLitDetMidTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *viewModel;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *lineLab;

@property (nonatomic, strong) UIView *lineView;

@end
