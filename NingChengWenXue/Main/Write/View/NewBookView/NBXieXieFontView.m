//
//  NBXieXieFontView.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/3.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBXieXieFontView.h"

@implementation NBXieXieFontView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpFontViewUI];
        
    }
    return self;
}

#pragma mark - 改变字体大小的按钮
- (void) setUpFontViewUI {
    UIView *fontView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 44)];
    fontView.backgroundColor = BXColor(236,105,65);
    [self addSubview:fontView];
    
    UIButton *addBtn = [[UIButton alloc] init];
    addBtn.frame = CGRectMake(BXScreenW/2.0 - 72, 10, 47, 23);
    [addBtn setTitle:@"A+" forState:UIControlStateNormal];
    addBtn.titleLabel.font = SIXFont;
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.borderWidth = 1;
    addBtn.borderColor = [UIColor whiteColor];
    addBtn.layer.cornerRadius = 5;
    [fontView addSubview:addBtn];
    self.addFontBtn = addBtn;
    
    UIButton *subBtn = [[UIButton alloc] init];
    subBtn.frame = CGRectMake(BXScreenW/2.0 + 25, 10, 47, 23);
    [subBtn setTitle:@"A-" forState:UIControlStateNormal];
    subBtn.titleLabel.font = SIXFont;
    subBtn.borderWidth = 1;
    subBtn.borderColor = [UIColor whiteColor];
    subBtn.layer.cornerRadius = 5;
    [fontView addSubview:subBtn];
    self.subFontBtn = subBtn;
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenNBXieXieSelf)]];
}

-(void) hiddenNBXieXieSelf {
    [self removeFromSuperview];
}

@end
