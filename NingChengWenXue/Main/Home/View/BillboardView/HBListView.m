//
//  HBListView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/1.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HBListView.h"

@implementation HBListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void) setup {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    backView.userInteractionEnabled = YES;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(BXScreenW - 60, 64, 55, 87)];
    imgView.image = [UIImage imageNamed:@"弹出_bg1"];
//    imgView.backgroundColor = [UIColor whiteColor];
    imgView.userInteractionEnabled = YES;
    [self addSubview:imgView];
    
    [self addSubview:backView];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(BXScreenW - 60, 64, 55, 87)];
    imgView1.image = [UIImage imageNamed:@"弹出_bg1"];
    imgView1.userInteractionEnabled = YES;
    [self addSubview:imgView1];
    
    self.BtnArray = [[NSMutableArray alloc] init];
//    NSArray *array = @[@"周榜",@"月榜",@"总榜"];
    for (int i = 0; i< 3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 29*i, 55, 28.5)];
        btn.titleLabel.font = THIRDFont;
//        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:BXColor(40,40,40) forState:UIControlStateNormal];
        [imgView1 addSubview:btn];
        [self.BtnArray addObject:btn];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 28.5, 55, 0.5)];
    line.backgroundColor = BXColor(195,195,195);
    [imgView1 addSubview:line];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 57.5, 55, 0.5)];
    lineLab.backgroundColor = BXColor(195,195,195);
    [imgView addSubview:lineLab];
    
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSelf)]];
}

- (void) click:(UIButton *)sender {
    [self removeFromSuperview];
    self.finishButtonName(sender.titleLabel.text);
}

-(void) hiddenSelf {
    [self removeFromSuperview];
}

@end
