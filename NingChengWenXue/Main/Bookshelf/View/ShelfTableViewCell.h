//
//  ShelfTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/25.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookShelfModel.h"

@interface ShelfTableViewCell : UITableViewCell

@property (nonatomic, strong) BookShelfModel *viewModel;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIImageView *typeImgView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *kanNumBtn;
@property (nonatomic, strong) UIButton *collectNumbtn;
@property (nonatomic, strong) UIButton *plNumBtn;
@property (nonatomic, strong) UILabel *typeLab;
@property (nonatomic, strong) UILabel *secNumLab;
@property (nonatomic, strong) UILabel *lineLab;
@property (nonatomic, strong) UIImageView *writerImg;
@property (nonatomic, strong) UILabel *writerLab;


@end
