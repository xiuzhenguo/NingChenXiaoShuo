//
//  MSenddetailTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxdetailModel.h"

@interface MSenddetailTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *viewModel;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *conLab;

@property (nonatomic, strong) UILabel *lineLab;

@property (nonatomic, strong) NSString *nameStr;

@end
