//
//  HMyClubHeadView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HMyClubHeadView.h"

@implementation HMyClubHeadView

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
    imgView.image = [UIImage imageNamed:@"狐狸-1"];
    imgView.layer.cornerRadius = 25;
    imgView.clipsToBounds= YES;
    [self addSubview:imgView];
    self.imgView = imgView;
    // 文学社名
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, BXScreenW - 90, 15)];
    nameLab.font = FIFFont;
    nameLab.textColor = BXColor(35,35,35);
    nameLab.text = @"微校园联盟";
    [self addSubview:nameLab];
    self.nameLab = nameLab;
    // 学校名
    UILabel *schNameLab = [[UILabel alloc] initWithFrame:CGRectMake(75, CGRectGetMaxY(nameLab.frame)+5, BXScreenW - 75 - 98, 15)];
    schNameLab.font = THIRDFont;
    schNameLab.textColor = BXColor(152,152,152);
    //    schNameLab.text = @"大连工业大学";
    [self addSubview:schNameLab];
    self.schNameLable = schNameLab;
    
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

- (void)setModel:(UnionDetailModel *)model{
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.Image] placeholderImage:[UIImage imageNamed:@"狐狸-1"]];
    
    self.nameLab.text = model.CommunityName;
    self.schNameLable.text = model.SchoolName;
    
    self.contentLab.text = model.Intro;
    self.contentLab.numberOfLines = 0;
    [self.contentLab sizeToFit];
    self.height = CGRectGetMaxY(self.contentLab.frame)+30;
    self.frame = CGRectMake(0, 0, BXScreenW, self.height);
    
    
}

@end
