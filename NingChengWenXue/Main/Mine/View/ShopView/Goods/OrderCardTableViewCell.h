//
//  OrderCardTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/11/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewModel.h"

@interface OrderCardTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *cardImg;//卡片图片

@property (nonatomic, strong) UILabel *nameLab;//卡片名字

@property (nonatomic, strong) UILabel *priceLab;//价格

@property (nonatomic, strong) UILabel *numLab;//数量

@property (nonatomic, strong) UILabel *allPriceLab;//总价格

@property (nonatomic, strong) UILabel *allNumLab;//总数量

@property (nonatomic, strong) UIButton *subBtn;//减少按钮

@property (nonatomic, strong) UIButton *addBtn;//增加按钮

@property (nonatomic, strong) UILabel *firLineLab;

@property (nonatomic, strong) UILabel *twoLineLab;

@property (nonatomic, strong) UILabel *thiLineLab;

@property (nonatomic, strong) UIView *lineView;


@property (nonatomic, strong) ViewModel *viewModel;
@property (nonatomic, assign) NSInteger currentCountNumber;

@end
