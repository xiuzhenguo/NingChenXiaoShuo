//
//  AccountLoginView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "AccountLoginView.h"

@implementation AccountLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPhoneLoginUI];
        [self setPhoneTexyField];
    }
    return self;
}


-(void) setPhoneLoginUI {
    
    UIButton *numImage = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 19, 52)];
    numImage.backgroundColor = [UIColor whiteColor];
    [numImage setImage:[UIImage imageNamed:@"账号"] forState:UIControlStateNormal];
    [self addSubview:numImage];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 52, BXScreenW - 30, 1)];
    lineLab.backgroundColor = The_Prompt_Color_Nine;
    [self addSubview:lineLab];
    
    UIButton *accountImg = [[UIButton alloc] initWithFrame:CGRectMake(15, 53, 19, 52)];
    [accountImg setImage:[UIImage imageNamed:@"密码"] forState:UIControlStateNormal];
    [self addSubview:accountImg];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, 105, BXScreenW - 30, 1)];
    line.backgroundColor = The_Prompt_Color_Nine;
    [self addSubview:line];
}

- (void) setPhoneTexyField {
    
    UITextField *phoneField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, BXScreenW - 65, 54)];
    phoneField.placeholder = @"请输入账号";
    phoneField.textColor = The_Prompt_Color_Nine;
    [self addSubview:phoneField];
    _accountNum = phoneField;
    
    UITextField *accountField = [[UITextField alloc] initWithFrame:CGRectMake(50, 53, BXScreenW - 65, 54)];
    accountField.placeholder = @"请输入密码";
    accountField.textColor = The_Prompt_Color_Nine;
    [self addSubview:accountField];
    _passwordField = accountField;
    
   
}

@end
