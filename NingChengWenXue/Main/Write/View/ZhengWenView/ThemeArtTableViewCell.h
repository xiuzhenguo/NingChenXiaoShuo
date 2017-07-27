//
//  ThemeArtTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhengWenListModel.h"

@interface ThemeArtTableViewCell : UITableViewCell

@property (nonatomic, strong) ZhengWenListModel *viewModel;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *introLab;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UIImageView *typeImgView;
@property (nonatomic, strong) UILabel *typeLab;
@property (nonatomic, strong) UIButton *hotNumBtn;
@property (nonatomic, strong) UIView *backView;

@end
