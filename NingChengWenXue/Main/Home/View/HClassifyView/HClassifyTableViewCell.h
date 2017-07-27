//
//  HClassifyTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeListModel.h"

@protocol MyCellDelegate <NSObject>
- (void)createUIButtonWithTitle:(NSString *)title Tag:(NSInteger)tag Section:(NSInteger)section;
@end

@interface HClassifyTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray     * arr;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak)   id<MyCellDelegate>delegate;

+ (HClassifyTableViewCell *)setMyTableViewCellWithTableView:(UITableView *)tableView;

@end
