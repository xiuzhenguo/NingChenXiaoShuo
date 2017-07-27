//
//  HEssenceLastTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/3.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExceedListModel.h"

@interface HEssenceLastTableViewCell : UITableViewCell

@property (nonatomic, strong) ExceedListModel *viewModel;

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UILabel *lineLab;


-(void) cellForModel:(ExceedListModel *)viewModel Row:(NSInteger)row;

@end
