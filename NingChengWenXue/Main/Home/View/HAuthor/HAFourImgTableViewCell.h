//
//  HAFourImgTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/23.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WriterDynModel.h"
#import "DynFictionModel.h"

@interface HAFourImgTableViewCell : UITableViewCell

@property (nonatomic, strong) WriterDynModel *viewModel;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) int num;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *conNameLab;

@property (nonatomic, strong) UILabel *contentLab;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *novelImg;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *writorLab;

@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UILabel *lineLab;

@end

