//
//  HComDetailTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPDetailModel.h"

@interface HComDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *comLable;

@property (nonatomic, strong) SPDetailModel *viewModel;
@property (nonatomic, strong) NSString *str;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIColor *color;

@end
