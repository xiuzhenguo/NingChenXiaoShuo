//
//  HAutCardSynView.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/29.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutCardSynView.h"

@implementation HAutCardSynView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViewUI];
    }
    return self;
}

-(void) setUpViewUI {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    backView.userInteractionEnabled = YES;
    [self addSubview:backView];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((BXScreenW - 155)/2.0, 140, 155, 195)];
    img.layer.shadowColor = BXColor(255,253,58).CGColor;//shadowColor阴影颜色
    img.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    img.layer.shadowOpacity = 0.7;//阴影透明度，默认0
    img.layer.shadowRadius = 20;//阴影半径，默认3
    [self addSubview:img];
    self.imgView = img;
    
    UILabel *name = [[UILabel alloc] init];
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont systemFontOfSize:18];
    name.layer.shadowColor = BXColor(255,0,0).CGColor;
    name.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    name.layer.shadowOpacity = 1;//阴影透明度，默认0
    name.layer.shadowRadius = 5;//阴影半径，默认3
    [self addSubview:name];
    self.nameLab = name;
    
    
    
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeBackView)]];
    
}

-(void) removeBackView {
    [self removeFromSuperview];
}


@end
