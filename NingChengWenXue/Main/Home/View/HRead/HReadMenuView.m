//
//  HReadMenuView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/24.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HReadMenuView.h"
#import "LSYTopMenuView.h"
#define AnimationDelay 0.3f
#define TopViewHeight 64.0f
#define BottomViewHeight 49.0f

@interface HReadMenuView ()<LSYMenuViewDelegate>

@end

@implementation HReadMenuView

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
    self.backgroundColor = [UIColor clearColor];
    // 添加顶部视图
    _topView = [[LSYTopMenuView alloc] init];
    [self addSubview:self.topView];
    
    // 添加底部视图
    _boomView = [[HRBoomMenuView alloc] init];
    [self addSubview:_boomView];

    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSelf)]];
}

-(LSYTopMenuView *)topView
{
    if (!_topView) {
        _topView = [[LSYTopMenuView alloc] init];
//        _topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        _topView.backgroundColor = [UIColor clearColor];
        _topView.delegate = self;
    }
    return _topView;
}

- (HRBoomMenuView *)boomView{
    
    if (!_boomView) {
        _boomView = [[HRBoomMenuView alloc] init];
        _boomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    
    }
    return _boomView;
}


#pragma mark - LSYMenuViewDelegate


//-(void)menuViewMark:(LSYTopMenuView *)topMenu
//{
//    if ([self.delegate respondsToSelector:@selector(menuViewMark:)]) {
//        [self.delegate menuViewMark:topMenu];
//    }
//}
#pragma mark -
-(void)hiddenSelf
{
//    [self hiddenAnimation:YES];
    if ([self.delegate respondsToSelector:@selector(menuViewMark)]) {
        [self.delegate menuViewMark];
    }
}
-(void)showAnimation:(BOOL)animation
{
    self.hidden = NO;
    self.topView.fontView.hidden = YES;
    [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
        _topView.frame = CGRectMake(0, 0, BXScreenW, TopViewHeight+44);
        
        _boomView.frame = CGRectMake(0, BXScreenH - BottomViewHeight, BXScreenW, BottomViewHeight);
        
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)hiddenAnimation:(BOOL)animation
{
    [UIView animateWithDuration:animation?AnimationDelay:0 animations:^{
        _topView.frame = CGRectMake(0, -TopViewHeight - 44, BXScreenW, TopViewHeight);
        
        _boomView.frame = CGRectMake(0, BXScreenH, BXScreenW,BottomViewHeight);
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.topView.fontView.hidden = YES;
    }];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _topView.frame = CGRectMake(0, -TopViewHeight-44, BXScreenW,TopViewHeight+44);
    _boomView.frame = CGRectMake(0, BXScreenH, BXScreenW,BottomViewHeight);
}
@end
