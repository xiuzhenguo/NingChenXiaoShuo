//
//  OrderHeader.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/11/3.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHeader : UIView

@property (nonatomic, strong) UILabel *perpleLab;//收货人

@property (nonatomic, strong) UILabel *phoneLab;//电话

@property (nonatomic, strong) UILabel *addressLab;//收货地址

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIImageView *addImg;

@property (nonatomic, strong) UILabel *moreLab;

@property (nonatomic, strong) UIImageView *lineImg;

@property (nonatomic, assign) CGFloat height;

@end
