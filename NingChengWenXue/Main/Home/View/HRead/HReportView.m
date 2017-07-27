//
//  HReportView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HReportView.h"

@implementation HReportView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setup];
    }
    return self;
}

- (void) setup {
    self.dataArray = @[@"广告等垃圾信息",@"色情内容",@"恶意人身攻击",@"违反法律法规",@"其他"];
    UIButton *headBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 217)];
    headBtn.backgroundColor = [UIColor blackColor];
    headBtn.alpha = 0.4;
    [self addSubview:headBtn];
    [headBtn addTarget:self action:@selector(viewhiddenSelf) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, BXScreenH - 271, BXScreenW, 271)];
    backView.backgroundColor = BXColor(242,242,242);
    [self addSubview:backView];
    
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 44.5*i, BXScreenW, 44)];
        btn.backgroundColor = [UIColor whiteColor];
        [backView addSubview:btn];
        btn.tag = 1000+i;
        [btn setTitle:self.dataArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:BXColor(40, 40, 40) forState:UIControlStateNormal];
    }
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 227, BXScreenW, 42)];
    cancleBtn.backgroundColor = [UIColor whiteColor];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancleBtn setTitleColor:BXColor(40, 40, 40) forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(clickCancleBtn) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancleBtn];
    
}

-(void) clickButton:(UIButton *)sender {
    
    self.finishButtonTitle([NSString stringWithFormat:@"%ld",sender.tag - 999]);
}

-(void) clickCancleBtn {
    [self removeFromSuperview];
}

- (void) viewhiddenSelf{
    [self removeFromSuperview];
}

@end
