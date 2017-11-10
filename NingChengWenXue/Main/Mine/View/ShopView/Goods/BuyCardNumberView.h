//
//  BuyCardNumberView.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/31.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyCardNumberView : UIView

@property (nonatomic, strong) UIImageView *cardImg;//卡片图片

@property (nonatomic, strong) UILabel *priceLab;//价格

@property (nonatomic, strong) UILabel *numLab;//购买数量

@property (nonatomic, strong) UIButton *sureBtn;//确定按钮

@property (nonatomic, assign) NSInteger currentCountNumber;//数量

@end
