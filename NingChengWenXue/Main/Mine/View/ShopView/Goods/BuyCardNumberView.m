//
//  BuyCardNumberView.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/31.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "BuyCardNumberView.h"

@implementation BuyCardNumberView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.currentCountNumber = 1;
        [self setup];
    }
    return self;
}

-(void)setup{
    // 上半部半透明状态
    UIButton *headBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 278)];
    headBtn.backgroundColor = [UIColor blackColor];
    headBtn.alpha = 0.4;
    [self addSubview:headBtn];
    [headBtn addTarget:self action:@selector(viewhiddenSelf) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, BXScreenH - 278, BXScreenW, 278)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    //卡片图片
    self.cardImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 21, 94, 119)];
    self.cardImg.image = [UIImage imageNamed:@"商品-数量图"];
    [backView addSubview:self.cardImg];
    //取消按钮
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 50, 21, 50, 20)];
    [cancelBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(viewhiddenSelf) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancelBtn];
    //直接购买
    UILabel *buyLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cardImg.frame)+12, 86, 65, 20)];
    buyLab.font = FIFFont;
    buyLab.textColor = BXColor(40, 40, 40);
    buyLab.text = @"立即购买";
    [backView addSubview:buyLab];
    // 价格
    self.priceLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(buyLab.frame)+8, 86, BXScreenW - CGRectGetMaxX(buyLab.frame)-15, 20)];
    self.priceLab.font = [UIFont boldSystemFontOfSize:15];
    self.priceLab.textColor = BXColor(236,105,65);
    self.priceLab.text = @"¥ 100";
    [backView addSubview:self.priceLab];
    //横线
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 159, BXScreenW - 30, 0.5)];
    lineLab.backgroundColor = BXColor(195,195,195);
    [backView addSubview:lineLab];
    //
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(15, 160, 65, 73)];
    num.textColor = BXColor(40, 40, 40);
    num.font = FIFFont;
    num.text = @"购买数量";
    [backView addSubview:num];
    
    /************************** 减 ****************************/
    UIButton *subBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 125, 181, 34, 30)];
    subBtn.backgroundColor = BXColor(251,251,251);
    [subBtn setTitle:@"－" forState:UIControlStateNormal];
    [subBtn setTitleColor:BXColor(203,203,203) forState:UIControlStateNormal];
    [subBtn addTarget:self action:@selector(clickSubButton) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:subBtn];
    
    /************************** 内容 ****************************/
    self.numLab = [[UILabel alloc] initWithFrame:CGRectMake(BXScreenW - 88, 181, 38, 30)];
    self.numLab.backgroundColor = BXColor(245,245,245);
    self.numLab.textColor = BXColor(40, 40, 40);
    self.numLab.text = [NSString stringWithFormat:@"%ld",self.currentCountNumber];
    self.numLab.font = FIFFont;
    self.numLab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:self.numLab];
    
    /************************** 加 ****************************/
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 48, 181, 34, 30)];
    addBtn.backgroundColor = BXColor(245,245,245);
    [addBtn setTitle:@"＋" forState:UIControlStateNormal];
    [addBtn setTitleColor:BXColor(145,145,145) forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:addBtn];
    // 确定按钮
    self.sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 233, BXScreenW, 45)];
    self.sureBtn.backgroundColor = BXColor(236,105,65);
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.sureBtn.titleLabel.font = FIFFont;
    [backView addSubview:self.sureBtn];
}

#pragma mark - 添加商品数量点击事件
-(void)clickAddButton{
    self.currentCountNumber++;
    self.numLab.text = [NSString stringWithFormat:@"%ld",self.currentCountNumber];
}

#pragma mark - 减少商品数量按钮的点击事件
-(void)clickSubButton{
    if (self.currentCountNumber <= 1) {
        NSLog(@"超出范围");
    }else{
        self.currentCountNumber = self.currentCountNumber - 1;
    }
    self.numLab.text = [NSString stringWithFormat:@"%ld",self.currentCountNumber];
    NSLog(@"%@",self.numLab.text);
    
}

#pragma mark -
-(void)viewhiddenSelf
{
    [self viewHiddenAnimation:YES];
}

- (void)viewHiddenAnimation:(BOOL)animation{
    self.hidden = YES;
}


@end
