//
//  RootTableHeaderView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/17.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTableHeaderView : UIView
/** 分区头标题 **/
@property (nonatomic, strong) UILabel *titleLab;
/** 分区头按钮 **/
@property (nonatomic, strong) UIButton *moreBtn;
/** 分区头图片 **/
@property (nonatomic, strong) UIImageView *headImage;
/** 分区头更多 **/
@property (nonatomic, strong) UIImageView *moreImage;

@end
