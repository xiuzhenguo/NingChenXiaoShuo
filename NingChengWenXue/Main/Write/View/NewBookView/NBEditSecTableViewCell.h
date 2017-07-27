//
//  NBEditSecTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/4.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionListModel.h"

@interface NBEditSecTableViewCell : UITableViewCell

@property (nonatomic, strong) SectionListModel *viewModel;

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *secLab;
@property (nonatomic, strong) UILabel *imgLab;
@property (nonatomic, strong) UIButton *imgbtn;
@property (nonatomic, strong) UILabel *lineLab;
@property (nonatomic, strong) UILabel *statusLab;

@end
