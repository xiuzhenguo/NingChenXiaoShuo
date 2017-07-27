//
//  ChangeNameTableViewCell.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/25.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeNameTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UITextField *tectfield;

@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) UILabel *lineLab;

@end
