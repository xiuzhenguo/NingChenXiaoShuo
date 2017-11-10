//
//  ShopTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopTableViewCell;
@protocol ShopBtnClickDelegate <NSObject>

-(void)BFCell:(ShopTableViewCell*)bfcell didClickBFBtnTag:(NSInteger)BFBtnTag currentBFBtn:(UIButton*)sender;

@end

@interface ShopTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel * classLab;
@property(nonatomic,strong)NSArray * classR;
@property(nonatomic,strong)UIScrollView * scroll;
@property(nonatomic, strong) UIButton *classBtn;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, assign) NSInteger section;

@property(nonatomic,weak)id<ShopBtnClickDelegate> delegate;
-(void)countOfButton:(NSInteger)count namearray:(NSArray *)dataArray;

@end
