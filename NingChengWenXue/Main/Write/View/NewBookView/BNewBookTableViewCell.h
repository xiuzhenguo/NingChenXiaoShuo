//
//  BNewBookTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/26.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewBookListModel.h"

@interface BNewBookTableViewCell : UITableViewCell

@property (nonatomic, strong) NewBookListModel *viewModel;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIButton *kanNumBtn;
@property (nonatomic, strong) UIButton *collectNumbtn;
@property (nonatomic, strong) UIButton *plNumBtn;
@property (nonatomic, strong) UILabel *typeLab;
@property (nonatomic, strong) UILabel *pageNumLab;
@property (nonatomic, strong) UILabel *secNumLab;
@property (nonatomic, strong) UILabel *lineLab;

@end
