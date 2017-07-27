//
//  HComDetailHeadView.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HComDetailHeadView.h"

@implementation HComDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpHeadViewUI];
    }
    return self;
}

-(void) setUpHeadViewUI {
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:15];
    self.nameLab.textColor = BXColor(40,40,40);
    [self addSubview:self.nameLab];
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = ELEFont;
    self.timeLab.textColor = BXColor(101,101,101);
    self.timeLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.timeLab];
    
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.font = THIRDFont;
    self.contentLab.textColor = BXColor(40,40,40);
    [self addSubview:self.contentLab];
    
    self.fromLab = [[UILabel alloc] init];
    self.fromLab.font = ELEFont;
    self.fromLab.textColor = BXColor(152,152,152);
    [self addSubview:self.fromLab];
    
    self.imgView = [[UIImageView alloc] init];
    [self addSubview:self.imgView];
    
    self.comBtn = [[UIButton alloc] init];
    [self.comBtn setTitleColor:BXColor(101, 101, 101) forState:UIControlStateNormal];
    self.comBtn.titleLabel.font = ELEFont;
    [self addSubview:self.comBtn];
    
    self.zanBtn = [[UIButton alloc] init];
    [self.zanBtn setTitleColor:BXColor(101, 101, 101) forState:UIControlStateNormal];
    self.zanBtn.titleLabel.font = ELEFont;
    [self addSubview:self.zanBtn];
    
}

- (void)setViewModel:(ShuPingListModel *)viewModel{
    for (UIView *view in self.subviews) {
        view.frame = CGRectZero;
    }
    self.imgView.frame = CGRectMake(15, 15, 112/2.0, 112/2.0);
    self.imgView.layer.cornerRadius = 112/4.0;
    self.imgView.clipsToBounds = YES;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.AuthorHeadImage] placeholderImage:[UIImage imageNamed:@"作者头像"]];
    
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 15, BXScreenW - 150, 20);
    self.nameLab.text = viewModel.AuthorName;
    
    self.timeLab.frame = CGRectMake(BXScreenW - 65, 20, 50, 15);
    self.timeLab.text = viewModel.PublishTime;
    
    self.contentLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, CGRectGetMaxY(self.nameLab.frame)+10, BXScreenW - 96, 2000);
    self.contentLab.text = viewModel.Content;
    self.contentLab.numberOfLines = 0;
    [self.contentLab sizeToFit];
    
    self.fromLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, CGRectGetMaxY(self.contentLab.frame)+15, BXScreenW - 96, 15);
    self.fromLab.text = [NSString stringWithFormat:@"来自第%ld章 %@",viewModel.SectionIndex,viewModel.SectionName];
    if (viewModel.PostClass == 1) {
        [self.fromLab removeFromSuperview];
        self.zanBtn.frame = CGRectMake(BXScreenW - 200, CGRectGetMaxY(self.contentLab.frame)+15, 125, 20);
        self.comBtn.frame = CGRectMake(BXScreenW - 60, CGRectGetMaxY(self.contentLab.frame)+15, 60, 20);
    }else{
        self.zanBtn.frame = CGRectMake(BXScreenW - 200, CGRectGetMaxY(self.fromLab.frame)+10, 125, 20);
        self.comBtn.frame = CGRectMake(BXScreenW - 60, CGRectGetMaxY(self.fromLab.frame)+10, 60, 20);
    }
    
    [self.zanBtn setTitle:[NSString stringWithFormat:@"%ld",viewModel.Applaud] forState:UIControlStateNormal];
    self.zanBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.zanBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    if (viewModel.IsApplaud == 0) {
         self.zanBtn.selected = NO;
        [self.zanBtn setImage:[UIImage imageNamed:@"赞"] forState:UIControlStateNormal];
    }else{
        self.zanBtn.selected = YES;
        [self.zanBtn setImage:[UIImage imageNamed:@"点赞_click"] forState:UIControlStateNormal];
    }

    [self.comBtn setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    [self.comBtn setTitle:[NSString stringWithFormat:@"%ld",viewModel.Reply] forState:UIControlStateNormal];
    self.comBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.comBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.lineLab.frame = CGRectMake(0, CGRectGetMaxY(self.zanBtn.frame)+9.5, BXScreenW, 0.5);
    
    self.height = CGRectGetMaxY(self.zanBtn.frame)+10;
}

@end
