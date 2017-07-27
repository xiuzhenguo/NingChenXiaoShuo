//
//  ThreeLoginView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ThreeLoginView.h"

@implementation ThreeLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLoginButtonUI];
//        [self setPhoneTexyField];
    }
    return self;
}

#pragma mark - 创建三方登录按钮
-(void) setLoginButtonUI {
    
    UIButton *weixinButton = [[UIButton alloc] initWithFrame:CGRectMake(62, 0, 60, 60)];
    [weixinButton setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [self addSubview:weixinButton];
    _weixinBtn = weixinButton;
    
    UIButton *weiboButton = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW/2 - 30, 0, 60, 60)];
    [weiboButton setImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
    [self addSubview:weiboButton];
    _weiboBtn = weiboButton;
    
    UIButton *QQBUtton = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 62 - 60, 0, 60, 60)];
    [QQBUtton setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [self addSubview:QQBUtton];
    _QQBtn = QQBUtton;
    
}

//-(void) setLoginButtonLable {
//    
//    UILabel *weixinLab = [[UILabel alloc] init];
//    weixinLab.centerX = _weixinBtn.centerX;
//    
//}

@end
