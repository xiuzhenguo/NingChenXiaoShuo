//
//  RootTableHeaderView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/17.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "RootTableHeaderView.h"

@implementation RootTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViewUI];
    }
    return self;
}

- (void) setUpViewUI {
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
    headImg.backgroundColor = [UIColor whiteColor];
    [self addSubview:headImg];
    _headImage = headImg;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 200, 50)];
    title.font = SIXFont;
    [self addSubview:title];
    _titleLab = title;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, BXScreenW - 205, 50)];
    btn.titleLabel.font = FIFFont;
    [self addSubview:btn];
    [btn setTitleColor:BXColor(152, 152, 152) forState:UIControlStateNormal];
    [btn setTitle:@"更多>" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self addSubview:btn];
    _moreBtn = btn;
    
    
    
}

@end
