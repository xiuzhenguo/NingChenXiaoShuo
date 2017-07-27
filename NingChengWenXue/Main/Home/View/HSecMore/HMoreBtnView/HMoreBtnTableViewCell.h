//
//  HMoreBtnTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/20.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMoreBtnCellDelegate <NSObject>
- (void)createUIButtonWithButton:(UIButton *)button Section:(NSInteger)section;
@end

@interface HMoreBtnTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray     * arr;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak)   id<HMoreBtnCellDelegate>delegate;

+ (HMoreBtnTableViewCell *)setMyTableViewCellWithTableView:(UITableView *)tableView;

@end
