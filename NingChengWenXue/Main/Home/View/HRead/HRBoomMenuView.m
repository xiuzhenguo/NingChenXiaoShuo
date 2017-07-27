//
//  HRBoomMenuView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/24.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HRBoomMenuView.h"

#import "HReadMenuView.h"

@implementation HRBoomMenuView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup
{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    UIButton *giftBUtton = [[UIButton alloc] init];
    [giftBUtton setImage:[UIImage imageNamed:@"礼物"] forState:UIControlStateNormal];
    giftBUtton.backgroundColor = BXColor(235, 182, 67);
    [self addSubview:giftBUtton];
    self.giftBtn = giftBUtton;
    
    UIButton *comButton = [[UIButton alloc] init];
    [comButton setImage:[UIImage imageNamed:@"评论-2"] forState:UIControlStateNormal];
    [self addSubview:comButton];
    self.commentBtn = comButton;
    
    UIButton *collectButton = [[UIButton alloc] init];
    [collectButton setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    [self addSubview:collectButton];
    self.collectBtn = collectButton;
    
    UIButton *shareButtom = [[UIButton alloc] init];
    [shareButtom setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [self addSubview:shareButtom];
    self.shareBtn = shareButtom;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    _giftBtn.frame = CGRectMake(0, 0, BXScreenW/4.0, self.frame.size.height);
    _commentBtn.frame = CGRectMake(BXScreenW/4.0, 0, BXScreenW/4.0, self.frame.size.height);
    _collectBtn.frame = CGRectMake(BXScreenW/4.0*2, 0, BXScreenW/4.0, self.frame.size.height);
    _shareBtn.frame = CGRectMake(BXScreenW/4.0*3, 0, BXScreenW/4.0, self.frame.size.height);
}


@end
