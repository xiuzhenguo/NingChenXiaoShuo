//
//  HClaDetTitTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/7.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HClaDetailCellDelegate <NSObject>
- (void)createUIButtonWithTypeName:(NSString *)typeName Tag:(NSInteger)tag Section:(NSInteger)section;

@end

@interface HClaDetTitTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray     * arr;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak)   id<HClaDetailCellDelegate>delegate;

+ (HClaDetTitTableViewCell *)setMyTableViewCellWithTableView:(UITableView *)tableView;

@end
