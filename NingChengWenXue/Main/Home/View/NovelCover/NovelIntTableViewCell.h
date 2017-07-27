//
//  NovelIntTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/21.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NovelDatailModel.h"
#import "PWContentView.h"

@interface NovelIntTableViewCell : UITableViewCell

@property (nonatomic, strong) NovelDatailModel *viewModel;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UILabel *introLab;
@property (nonatomic, strong) UILabel *lineLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIImageView *moreImg;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) PWContentView *pwView;
@property (nonatomic, strong) NSArray *array;

@end
