//
//  NBEditPhoneView.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock) (UIImage *img);

@interface NBEditPhoneView : UIView

@property (nonatomic, strong) selectBlock finishButtonTitle;

@property (nonatomic, strong) UIButton *camBtn;

@property (nonatomic, strong) UIButton *phoBtn;

@end
