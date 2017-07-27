//
//  TyrantTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/20.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BookListModel.h"
@interface TyrantTableViewCell : UITableViewCell

@property(nonatomic,strong)BookListModel * viewModel;
@property(nonatomic,assign)CGFloat hetght;
@property (nonatomic, assign) NSInteger row;


@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *SignatureLab;

@property (nonatomic, strong) UILabel *contributeLab;


@end

