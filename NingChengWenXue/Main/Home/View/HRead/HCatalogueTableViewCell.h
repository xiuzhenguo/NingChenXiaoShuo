//
//  HCatalogueTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/24.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MuLuListModel.h"

@interface HCatalogueTableViewCell : UITableViewCell

@property(nonatomic, strong) MuLuListModel *viewModel;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *wordNumLab;
@property (nonatomic, strong) UILabel *imgNumlab;
@property (nonatomic, strong) UILabel *typeLab;

@property (nonatomic, strong) UILabel *lineLab;

@end
