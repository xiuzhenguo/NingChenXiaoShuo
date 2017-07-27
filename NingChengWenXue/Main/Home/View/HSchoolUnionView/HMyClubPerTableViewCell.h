//
//  HMyClubPerTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserItemModel.h"

@interface HMyClubPerTableViewCell : UITableViewCell

@property (nonatomic, strong) UserItemModel *viewModel;

//测试
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger role;


@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *jobLab;

@property (nonatomic, strong) UILabel *bookLab;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UILabel *lineLab;

@end
