//
//  TABookTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/11.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TABookTableViewCell : UITableViewCell

@property (assign, nonatomic) NSIndexPath *selectedIndexPath;

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *lineLab;
@property (nonatomic, strong) UIButton *imgView;

@end
