//
//  TAWeiTouGaoTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWDetailModel.h"

@interface TAWeiTouGaoTableViewCell : UITableViewCell

@property (nonatomic, strong) ZWDetailModel *viewModel;
@property (nonatomic, assign) NSInteger row;

@property (weak, nonatomic) IBOutlet UILabel *rankLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *writorLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;

@end
