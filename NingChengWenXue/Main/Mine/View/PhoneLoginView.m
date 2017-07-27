//
//  PhoneLoginView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/14.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "PhoneLoginView.h"
#import "HelperUtil.h"

@implementation PhoneLoginView

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
    [numImage setImage:[UIImage imageNamed:@"手机"] forState:UIControlStateNormal];
    [self addSubview:numImage];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 52, BXScreenW - 30, 1)];
    lineLab.backgroundColor = The_Prompt_Color_Nine;
    [self addSubview:lineLab];
    
    UIButton *accountImg = [[UIButton alloc] initWithFrame:CGRectMake(15, 53, 19, 52)];
    [accountImg setImage:[UIImage imageNamed:@"验证码"] forState:UIControlStateNormal];
    [self addSubview:accountImg];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, 105, BXScreenW - 30, 1)];
    line.backgroundColor = The_Prompt_Color_Nine;
    [self addSubview:line];
}

- (void) setPhoneTexyField {
    
    UITextField *phoneField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, BXScreenW - 65, 54)];
    phoneField.placeholder = @"请输入您的手机号";
    phoneField.textColor = The_Prompt_Color_Nine;
    [self addSubview:phoneField];
    _phoneNum = phoneField;
    
    UITextField *accountField = [[UITextField alloc] initWithFrame:CGRectMake(50, 53, BXScreenW - 186, 54)];
    accountField.placeholder = @"请输入短信验证码";
    accountField.textColor = The_Prompt_Color_Nine;
    [self addSubview:accountField];
    _codeField = accountField;
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 156, 53, 136, 54)];
    [btn setTitleColor:BXColor(251, 80, 0) forState:UIControlStateNormal];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
//    // button标题居左显示
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    [btn addTarget:self action:@selector(clickCodeButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    _getCode = btn;
}


@end
