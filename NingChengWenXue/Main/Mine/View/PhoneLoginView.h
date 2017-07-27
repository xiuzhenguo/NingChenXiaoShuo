//
//  PhoneLoginView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/14.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCWelcomHepler.h"
#import "ETTimeManager.h"

@interface PhoneLoginView : UIView

@property (nonatomic, strong) UITextField *phoneNum;
@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) UIButton *getCode;

@end

static NSString * Get_ID_Key = @"getregistid";
