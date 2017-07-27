//
//  WordsTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/20.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BookListModel.h"
@interface WordsTableViewCell : UITableViewCell

@property(nonatomic,strong)BookListModel * viewModel;
@property(nonatomic,assign)CGFloat hetght;
@property(nonatomic,assign) NSInteger cellrow;


@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, strong) UILabel *VigorousLab;

@property (nonatomic, strong) UILabel *WordsLab;

@property (nonatomic, strong) UILabel *rankLab;

@property (nonatomic, strong) UILabel *IDLab;


@end

