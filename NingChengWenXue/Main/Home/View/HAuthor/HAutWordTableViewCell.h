//
//  HAutWordTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/30.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LeaveMessageModel.h"

@interface HAutWordTableViewCell : UITableViewCell

@property (nonatomic, strong) LeaveMessageModel *viewModel;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UILabel *contentLab;

@property (nonatomic, strong) UIButton *comBtn;

@property (nonatomic, strong) UILabel *lineLab;

@end

