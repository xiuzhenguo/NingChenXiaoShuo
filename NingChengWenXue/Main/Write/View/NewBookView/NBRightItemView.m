//
//  NBRightItemView.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBRightItemView.h"

@implementation NBRightItemView

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
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(BXScreenW - 96, 64, 86, 168)];
    imgView.image = [UIImage imageNamed:@"弹出_bg1"];
    //    imgView.backgroundColor = [UIColor whiteColor];
    imgView.userInteractionEnabled = YES;
    [self addSubview:imgView];
    
    [self addSubview:backView];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(BXScreenW - 96, 64, 86, 168)];
    imgView1.image = [UIImage imageNamed:@"弹出_bg1"];
    imgView1.userInteractionEnabled = YES;
    [self addSubview:imgView1];
    
    self.BtnArray = [[NSMutableArray alloc] init];
    NSArray *array = @[@"阅读",@"申请签约",@"删除作品",@"分享"];
    for (int i = 0; i< 4; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 42*i, 86, 41.5)];
        btn.titleLabel.font = FIFFont;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:BXColor(40,40,40) forState:UIControlStateNormal];
        [imgView1 addSubview:btn];
        btn.tag = 1000 + i;
        [self.BtnArray addObject:btn];
    
    }
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 41.5, 86, 0.5)];
    line.backgroundColor = BXColor(195,195,195);
    [imgView1 addSubview:line];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 83.5, 86, 0.5)];
    lineLab.backgroundColor = BXColor(195,195,195);
    [imgView1 addSubview:lineLab];
    
    UILabel *lineLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 125.5, 86, 0.5)];
    lineLab2.backgroundColor = BXColor(195,195,195);
    [imgView1 addSubview:lineLab2];
    
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSelf)]];
}


-(void) hiddenSelf {
    [self removeFromSuperview];
}

@end
