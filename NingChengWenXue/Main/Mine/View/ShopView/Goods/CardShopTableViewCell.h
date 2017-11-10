//
//  CardShopTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeListModel.h"

@protocol CardShopCellDelegate <NSObject>
- (void)createUIButtonWithTitle:(NSString *)title Tag:(NSInteger)tag;
@end

@interface CardShopTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray     * arr;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, weak)   id<CardShopCellDelegate>delegate;


@end
