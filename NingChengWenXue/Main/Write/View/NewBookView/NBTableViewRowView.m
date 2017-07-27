//
//  NBTableViewRowView.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBTableViewRowView.h"

@implementation NBTableViewRowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void) setup {
    NSArray *array = @[@"立即发布",@"定时发布",@"预览",@"删除"];
    UIButton *headBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 217)];
    headBtn.backgroundColor = [UIColor blackColor];
    headBtn.alpha = 0.4;
    [self addSubview:headBtn];
    [headBtn addTarget:self action:@selector(viewhiddenSelf) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, BXScreenH - 225, BXScreenW, 225)];
    backView.backgroundColor = BXColor(242,242,242);
    [self addSubview:backView];
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 44*i, BXScreenW, 43)];
        btn.backgroundColor = [UIColor whiteColor];
        [backView addSubview:btn];
        btn.tag = 1000+i;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:BXColor(40, 40, 40) forState:UIControlStateNormal];
//        [self.dataArray addObject:btn];
        [btn addTarget:self action:@selector(clickTableRowViewButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 181, BXScreenW, 44)];
    cancleBtn.backgroundColor = [UIColor whiteColor];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancleBtn setTitleColor:BXColor(40, 40, 40) forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(clickCancleBtn) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancleBtn];
    
}

-(void) clickTableRowViewButton:(UIButton *)sender {
    [self removeFromSuperview];
    self.finishButtonTitle([NSString stringWithFormat:@"%ld",(long)sender.tag]);
}


-(void) clickCancleBtn {
    [self removeFromSuperview];
}

- (void) viewhiddenSelf{
    [self removeFromSuperview];
}

@end
