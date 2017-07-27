//
//  ScrollTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/16.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollTableViewCell;
@protocol BFBtnClickDelegate <NSObject>

-(void)BFCell:(ScrollTableViewCell*)bfcell didClickBFBtnTag:(NSInteger)BFBtnTag currentBFBtn:(UIButton*)sender;

@end

@interface ScrollTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * classLab;
@property(nonatomic,strong)NSArray * classR;
@property(nonatomic,strong)UIScrollView * scroll;
@property(nonatomic, strong) UIButton *classBtn;
@property (nonatomic, assign) NSInteger section;

@property(nonatomic,weak)id<BFBtnClickDelegate> delegate;
-(void)countOfButton:(NSInteger)count namearray:(NSArray *)nameArray imgarray:(NSArray *)imgArray;

@end

