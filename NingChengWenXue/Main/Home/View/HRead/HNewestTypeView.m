//
//  HNewestTypeView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HNewestTypeView.h"

@implementation HNewestTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void) setup {
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewhiddenSelf)]];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(BXScreenW - 91, 0, 86, 84)];
    imgView.image = [UIImage imageNamed:@"弹出_bg"];
    imgView.userInteractionEnabled = YES;
    [self addSubview:imgView];
    self.backImgView = imgView;
    
    UIButton *newBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 86, 42)];
    [newBtn setTitle:@"最新" forState:UIControlStateNormal];
    [newBtn setImage:[UIImage imageNamed:@"最新"] forState:UIControlStateNormal];
    [newBtn setImageEdgeInsets:UIEdgeInsetsMake(0, newBtn.titleLabel.bounds.size.width-5, 0, -newBtn.titleLabel.bounds.size.width+5)];
    newBtn.titleLabel.font = FIFFont;
    [imgView addSubview:newBtn];
    self.newestBtn = newBtn;
    
    UIButton *hotBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 42, 86, 42)];
    [hotBtn setTitle:@"最热" forState:UIControlStateNormal];
    [hotBtn setImage:[UIImage imageNamed:@"最热"] forState:UIControlStateNormal];
    [hotBtn setImageEdgeInsets:UIEdgeInsetsMake(0, hotBtn.titleLabel.bounds.size.width-5, 0, -hotBtn.titleLabel.bounds.size.width+5)];
    hotBtn.titleLabel.font = FIFFont;
    [imgView addSubview:hotBtn];
    self.hostBtn = hotBtn;
    
}

#pragma mark -
-(void)viewhiddenSelf
{
    [self viewHiddenAnimation:YES];
}

- (void)viewShowAnimation:(BOOL)animation{
    self.hidden = NO;
}

- (void)viewHiddenAnimation:(BOOL)animation{
    self.hidden = YES;
}

@end
