//
//  HLitDetailHeaderView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HLitDetailHeaderView.h"

@implementation HLitDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void) setup {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12.5, 50, 50)];
//    imgView.image = [UIImage imageNamed:@"狐狸-1"];
    imgView.layer.cornerRadius = 25;
    imgView.clipsToBounds= YES;
    [self addSubview:imgView];
    self.imgView = imgView;
    // 文学社名
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(75, 12.5, BXScreenW - 90, 15)];
    nameLab.font = FIFFont;
    nameLab.textColor = BXColor(35,35,35);
//    nameLab.text = @"微校园联盟";
    [self addSubview:nameLab];
    self.nameLab = nameLab;
    // 学校名
    UILabel *schNameLab = [[UILabel alloc] initWithFrame:CGRectMake(75, CGRectGetMaxY(nameLab.frame)+5, BXScreenW - 75 - 98, 13)];
    schNameLab.font = THIRDFont;
    schNameLab.textColor = BXColor(152,152,152);
//    schNameLab.text = @"大连工业大学";
    [self addSubview:schNameLab];
    self.schNameLable = schNameLab;
    // 社团名
    UILabel *clubLab = [[UILabel alloc] initWithFrame:CGRectMake(75, CGRectGetMaxY(schNameLab.frame)+5, BXScreenW - 75 - 98, 13)];
    clubLab.font = THIRDFont;
    clubLab.textColor = BXColor(152, 152, 152);
    clubLab.text = @"实体文学社";
    [clubLab sizeToFit];
    [self addSubview:clubLab];
    //排名
    UILabel *rankLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(clubLab.frame)+15, CGRectGetMaxY(schNameLab.frame)+5, 55, 13)];
    rankLab.textColor = BXColor(152, 152, 152);
    rankLab.font = THIRDFont;
//    rankLab.text = @"排名 1";
    [self addSubview:rankLab];
    self.rankLab = rankLab;
    // 按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 88, 36, 73, 26)];
    [btn setTitle:@"申请加入" forState:UIControlStateNormal];
    btn.titleLabel.font = FIFFont;
    [self addSubview:btn];
    self.joinBtn = btn;
    // 分割线
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 74.5, BXScreenW, 0.5)];
    lineLab.backgroundColor = BXColor(195,195,195);
    [self addSubview:lineLab];
    // 介绍
    self.contentLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, BXScreenW - 30, 1000)];
    self.contentLab.textColor = BXColor(101,101,101);
    self.contentLab.font = THIRDFont;
    [self addSubview:self.contentLab];
   
}

//- (void)setConStr:(NSString *)conStr{
//    _conStr = conStr;
//    self.contentLab.text = conStr;
//    self.contentLab.numberOfLines = 0;
//    [self.contentLab sizeToFit];
//    self.height = CGRectGetMaxY(self.contentLab.frame)+30;
//    self.frame = CGRectMake(0, 0, BXScreenW, self.height);
//}

- (void)setModel:(UnionDetailModel *)model{
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.Image] placeholderImage:[UIImage imageNamed:@"狐狸-1"]];
    
    self.nameLab.text = model.CommunityName;
    self.schNameLable.text = model.SchoolName;
    self.rankLab.text = [NSString stringWithFormat:@"排名 %ld",model.Index];
    
    self.contentLab.text = model.Intro;
    self.contentLab.numberOfLines = 0;
    [self.contentLab sizeToFit];
    self.height = CGRectGetMaxY(self.contentLab.frame)+30;
    self.frame = CGRectMake(0, 0, BXScreenW, self.height);
    if (model.UserStatus == 1) {
        [self.joinBtn setTitle:@"申请加入" forState:UIControlStateNormal];
        self.joinBtn.backgroundColor = BXColor(59,192,137);
    }else if (model.UserStatus == 2){
        [self.joinBtn setTitle:@"取消申请" forState:UIControlStateNormal];
        self.joinBtn.backgroundColor = BXColor(236,105,65);
    }else{
        [self.joinBtn removeFromSuperview];
    }
    
}

@end
