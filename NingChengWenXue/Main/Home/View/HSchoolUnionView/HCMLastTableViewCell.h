//
//  HCMLastTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/9.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UnionHomeModel.h"

@interface HCMLastTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *lineLab;


@property (nonatomic, assign) CGFloat height;

-(void) setWithViewModel:(UnionHomeModel *)viewModel Row:(NSInteger)row;

@end
