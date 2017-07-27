//
//  NBEditPhoneView.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBEditPhoneView.h"

@implementation NBEditPhoneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void) setup {

    UIButton *headBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 135)];
    headBtn.backgroundColor = [UIColor blackColor];
    headBtn.alpha = 0.4;
    [self addSubview:headBtn];
    [headBtn addTarget:self action:@selector(viewhiddenSelf) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, BXScreenH - 142, BXScreenW, 142)];
    backView.backgroundColor = BXColor(242,242,242);
    [self addSubview:backView];
    // 照相
    UIButton *cameBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 43)];
    cameBtn.backgroundColor = [UIColor whiteColor];
    [cameBtn setImage:[UIImage imageNamed:@"照相"] forState:UIControlStateNormal];
    [cameBtn setTitle:@"照相" forState:UIControlStateNormal];
    cameBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cameBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [cameBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [backView addSubview:cameBtn];
    self.camBtn = cameBtn;
    
    // 相册
    UIButton *phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 44, BXScreenW, 48.5)];
    phoneBtn.backgroundColor = [UIColor whiteColor];
    [backView addSubview:phoneBtn];
    self.phoBtn = phoneBtn;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(cameBtn.imageView.frame), 8, 15, 15)];
    imgView.image = [UIImage imageNamed:@"相册"];
    [phoneBtn addSubview:imgView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+5, 8, 100, 15)];
    lab.font = [UIFont systemFontOfSize:17];
    lab.text = @"相册";
    [phoneBtn addSubview:lab];
    
    UILabel *noteLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, BXScreenW, 11)];
    noteLab.font = ELEFont;
    noteLab.textColor = BXColor(152,152,152);
    noteLab.textAlignment = NSTextAlignmentCenter;
    noteLab.text = @"请上传原创图片，网络图片未经授权涉嫌侵权";
    [phoneBtn addSubview:noteLab];
    
    
    // 取消按钮
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 98, BXScreenW, 44)];
    cancleBtn.backgroundColor = [UIColor whiteColor];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(clickCancleBtn) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancleBtn];
    
}

-(void) clickCancleBtn {
    [self removeFromSuperview];
}

- (void) viewhiddenSelf{
    [self removeFromSuperview];
}

@end
