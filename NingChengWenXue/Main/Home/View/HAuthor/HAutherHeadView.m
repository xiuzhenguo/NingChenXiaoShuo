//
//  HAutherHeadView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/22.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutherHeadView.h"

@implementation HAutherHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpHeadViewUI];
    }
    return self;
}


-(void) setUpHeadViewUI {
    // 作者头像
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 75, 105)];
    imgView.image = [UIImage imageNamed:@"作者"];
    [self addSubview:imgView];
    self.imgView = imgView;
    //名称
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+10, 15, 220, 20)];
    nameLab.text = @"小樱";
    nameLab.font = [UIFont boldSystemFontOfSize:15];
    nameLab.textColor = BXColor(255, 255, 255);
    [nameLab sizeToFit];
    [self addSubview:nameLab];
    self.nameLab = nameLab;
    // 等级
    UILabel *rankLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLab.frame)+10, 17, 32, 15)];
    rankLab.text = @"Lv20";
    rankLab.textColor = BXColor(0,160,233);
    rankLab.textAlignment = NSTextAlignmentCenter;
    rankLab.font = ELEFont;
    rankLab.borderWidth = 1;
    rankLab.borderColor = BXColor(0, 160, 233);
    [self addSubview:rankLab];
    self.rankLab = rankLab;
    //UUID
    UILabel *idLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+10, CGRectGetMaxY(nameLab.frame)+10, 150, 15)];
    idLab.text = @"(UUID:13578678)";
    [idLab sizeToFit];
    idLab.textColor = BXColor(255, 255, 255);
    idLab.font = THIRDFont;
    [self addSubview:idLab];
    self.IDLab = idLab;
    // 门派
    UILabel *marlab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(idLab.frame)+19, 45, 140, 15)];
    marlab.font = THIRDFont;
    marlab.text = @"门派：逍遥门";
    [marlab sizeToFit];
    marlab.textColor = BXColor(255, 255, 255);
    [self addSubview:marlab];
    self.martialLab = marlab;
   // 活力
    UILabel *vigLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+10, CGRectGetMaxY(idLab.frame)+10, 130, 15)];
    vigLab.textColor = BXColor(255, 255, 255);
    vigLab.font = THIRDFont;
    vigLab.text = @"活力：88888888";
    [vigLab sizeToFit];
    [self addSubview:vigLab];
    self.vigorousLab = vigLab;
    // 人品
    UILabel *perLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(vigLab.frame)+49, CGRectGetMaxY(idLab.frame)+10, 130, 15)];
    perLab.textColor = BXColor(255, 255, 255);
    perLab.font = THIRDFont;
    perLab.text = @"人品：30333";
    [perLab sizeToFit];
    [self addSubview:perLab];
    self.personLab = perLab;
    //卡片
    UIImageView *cardImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+10, CGRectGetMaxY(vigLab.frame)+10, 19, 22)];
    cardImg.image = [UIImage imageNamed:@"如来佛"];
    cardImg.userInteractionEnabled = YES;
    [self addSubview:cardImg];
    self.cardImgView = cardImg;
    UILabel *cardLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cardImg.frame)+5, CGRectGetMidY(cardImg.frame) - 8, 30, 15)];
    cardLab.text = @"卡片";
    [cardLab sizeToFit];
    cardLab.userInteractionEnabled = YES;
    cardLab.textColor = BXColor(255, 255, 255);
    cardLab.font = THIRDFont;
    [self addSubview:cardLab];
    UIImageView *cardImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cardLab.frame)-5, CGRectGetMidY(cardImg.frame) - 5, 15, 15)];
    cardImage.image = [UIImage imageNamed:@"卡片箭头"];
    cardImage.userInteractionEnabled = YES;
    [self addSubview:cardImage];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+10, CGRectGetMaxY(vigLab.frame)+10, CGRectGetMaxX(cardImage.frame)- CGRectGetMaxX(imgView.frame)-10, 22)];
    btn.backgroundColor = [UIColor clearColor];
    [self addSubview:btn];
    self.cardBtn = btn;
    
    // 勋章
    UIImageView *orderImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cardImage.frame)+30, CGRectGetMinY(cardImg.frame), 19, 25)];
    orderImg.image = [UIImage imageNamed:@"阿姆斯特朗大炮"];
    [self addSubview:orderImg];
    self.orderImgView = orderImg;
    UILabel *orderLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(orderImg.frame)+5, CGRectGetMidY(orderImg.frame) - 10, 30, 15)];
    orderLab.text = @"勋章";
    [orderLab sizeToFit];
    orderLab.textColor = BXColor(255, 255, 255);
    orderLab.font = THIRDFont;
    [self addSubview:orderLab];
    
    UIImageView *ordImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(orderLab.frame)-5, CGRectGetMidY(orderImg.frame) - 5, 15, 15)];
    ordImage.image = [UIImage imageNamed:@"卡片箭头"];
    [self addSubview:ordImage];
    
    UIButton *medal = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cardImage.frame)+30, CGRectGetMinY(cardImg.frame), CGRectGetMaxX(ordImage.frame)- CGRectGetMinX(orderImg.frame), 25)];
    medal.backgroundColor = [UIColor clearColor];
    [self addSubview:medal];
    self.medalBtn = medal;
    
}

- (void)setModel:(WriterDetailModel *)model{
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.AuthotImage] placeholderImage:[UIImage imageNamed:@"作者"]];
    self.nameLab.text = model.AuthorName;
    self.rankLab.text = [NSString stringWithFormat:@"Lv%ld",(long)model.lv];
    self.IDLab.text = [NSString stringWithFormat:@"(UUID:%@)",model.UUID];
    self.martialLab.text = [NSString stringWithFormat:@"门派:%@",model.Martial];
    self.vigorousLab.text = [NSString stringWithFormat:@"活力:%ld",(long)model.Energy];
    self.personLab.text = [NSString stringWithFormat:@"人品:%@",model.Moral];
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 15, BXScreenW - 160, 20);
    [self.nameLab sizeToFit];
    self.rankLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame)+10, 17, 32, 15);
    self.IDLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, CGRectGetMaxY(self.nameLab.frame)+10, 150, 15);
    [self.IDLab sizeToFit];
    // 门派
    self.martialLab.frame = CGRectMake(CGRectGetMaxX(self.IDLab.frame)+19, 45, 140, 15);
    [self.martialLab sizeToFit];
    
    // 活力
    self.vigorousLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, CGRectGetMaxY(self.IDLab.frame)+10, 130, 15);
    [self.vigorousLab sizeToFit];
    
    self.personLab.frame = CGRectMake(CGRectGetMaxX(self.vigorousLab.frame)+49, CGRectGetMaxY(self.IDLab.frame)+10, 130, 15);
    [self.personLab sizeToFit];
}

@end
