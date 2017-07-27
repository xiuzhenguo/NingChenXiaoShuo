//
//  LSYTopMenuView.m
//  LSYReader
//
//  Created by Labanotation on 16/6/1.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import "LSYTopMenuView.h"
#import "HReadMenuView.h"

@implementation LSYTopMenuView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setUpFontViewUI];
        self.fontView.hidden = YES;
    }
    return self;
}
-(void)setup
{
    
//    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [self addSubview:headView];
    self.headerView = headView;
    
    UIButton *cataBtn = [[UIButton alloc] init];
    [cataBtn setImage:[UIImage imageNamed:@"目录"] forState:UIControlStateNormal];
    [headView addSubview:cataBtn];
    self.cataButton = cataBtn;
    
    UIButton *back = [[UIButton alloc] init];
    [back setImage:[UIImage imageNamed:@"navigationbar_back_image"] forState:UIControlStateNormal];
    [headView addSubview:back];
    back.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    back.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.backButton = back;
    
    UIButton *fontButton = [[UIButton alloc] init];
    [fontButton setTitle:@"Aa" forState:UIControlStateNormal];
    fontButton.titleLabel.font = [UIFont systemFontOfSize:21];
    fontButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    fontButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [headView addSubview:fontButton];
    self.fontbtn = fontButton;
    [fontButton addTarget:self action:@selector(clickChangeFontButton) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 改变字体大小的按钮
- (void) setUpFontViewUI {
    UIView *fontView = [[UIView alloc] init];
    fontView.backgroundColor = BXColor(0, 0, 0);
    [self addSubview:fontView];
    self.fontView = fontView;
    
//    self.fontView.hidden = YES;
    
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setTitle:@"A+" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    addBtn.borderWidth = 1;
    addBtn.borderColor = [UIColor whiteColor];
    addBtn.layer.cornerRadius = 5;
    [self.fontView addSubview:addBtn];
    self.addFontBtn = addBtn;
    
    UIButton *subBtn = [[UIButton alloc] init];
    [subBtn setTitle:@"A-" forState:UIControlStateNormal];
    subBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    subBtn.borderWidth = 1;
    subBtn.borderColor = [UIColor whiteColor];
    subBtn.layer.cornerRadius = 5;
    [self.fontView addSubview:subBtn];
    self.subFontBtn = subBtn;
}

#pragma mark - 改变字体的点击方法
- (void) clickChangeFontButton {
    self.fontView.hidden = NO;
}

#pragma mark - 设置空间的坐标
-(void)layoutSubviews
{
    [super layoutSubviews];
    _headerView.frame = CGRectMake(0, 0, BXScreenW, 64);
    _backButton.frame = CGRectMake(15, 24, 100, 40);
    _cataButton.frame = CGRectMake(BXScreenW-55, 24, 40, 40);
    _fontbtn.frame = CGRectMake(BXScreenW - 113, 24, 40, 40);
    _fontView.frame = CGRectMake(0, 64, BXScreenW, 44);
    _addFontBtn.frame = CGRectMake(BXScreenW/2.0 - 72, 10, 47, 23);
    _subFontBtn.frame = CGRectMake(BXScreenW/2.0 + 25, 10, 47, 23);
    
}


@end
