//
//  TestCell.h
//  RefreshTest
//
//  Created by imac on 16/8/12.
//  Copyright © 2016年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestCellDelegate <NSObject>

- (void)SelectedCell:(UIButton*)sender;

@end

@interface TestCell : UITableViewCell
/**
 *  点击按钮（可以换成imageView不过点击事件就要改成手势了）
 */
@property (strong,nonatomic) UIButton *testBtn;
/**
 *  cell选项文本
 */
@property (strong,nonatomic) UILabel *testLb;

@property (weak,nonatomic) id<TestCellDelegate>delegate;
@end
