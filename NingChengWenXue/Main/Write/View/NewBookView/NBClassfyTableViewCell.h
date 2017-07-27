//
//  NBClassfyTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeListModel.h"

@protocol MyCellDelegate <NSObject>
- (void)createUIButtonWithTitle:(UIButton *)title Section:(NSInteger)section;
@end

@interface NBClassfyTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *lineLab;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) NSArray     * arr;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) NSInteger section;

@property (nonatomic, weak)   id<MyCellDelegate>delegate;

+ (NBClassfyTableViewCell *)setMyTableViewCellWithTableView:(UITableView *)tableView;

@end
