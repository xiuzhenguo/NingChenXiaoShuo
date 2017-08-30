//
//  TARuleHeadView.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TARuleHeadView.h"

@implementation TARuleHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpHeadViewUI];
    }
    return self;
}

-(void) setUpHeadViewUI {
    // 活动名
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = FIFFont;
    self.titleLab.textColor = BXColor(40,40,40);
    [self addSubview:self.titleLab];
//    // 投稿时间
//    self.timeLab = [[UILabel alloc] init];
//    self.timeLab.font = THIRDFont;
//    self.timeLab.textColor = BXColor(152,152,152);
//    [self addSubview:self.timeLab];
    // 内容
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.font = THIRDFont;
    self.contentLab.textColor = BXColor(152,152,152);
    [self addSubview:self.contentLab];
    
//    // 活动规则
//    self.guizeLab = [[UILabel alloc] init];
//    self.guizeLab.textColor = BXColor(152, 152, 152);
//    self.guizeLab.font = THIRDFont;
//    [self addSubview:self.guizeLab];
    
    // 进度
    self.typeImg = [[UIImageView alloc] init];
    [self addSubview:self.typeImg];
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.textColor = BXColor(152, 152, 152);
    self.typeLab.font = ELEFont;
    self.typeLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.typeLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(242, 242, 242);
    [self addSubview:self.lineLab];
    
    // 活动图片
    self.imgView = [[UIImageView alloc] init];
    [self addSubview:self.imgView];
}

- (void)setViewModel:(ZhengWenListModel *)viewModel{
    for (UIView *view in self.subviews) {
        view.frame = CGRectZero;
    }
    self.imgView.frame = CGRectMake(0, 0, BXScreenW, 130);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.FileImage] placeholderImage:[UIImage imageNamed:@"默认图片"]];
    
    // 活动名
    self.titleLab.text = viewModel.Title;
    CGRect nameWith = [self.titleLab.text boundingRectWithSize:CGSizeMake(BXScreenW - 110, 60) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(self.titleLab.font)} context:nil];
    self.titleLab.frame = CGRectMake(15, 23 + 130, nameWith.size.width, nameWith.size.height);
    // 进度
    self.typeLab.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame)+6, 21.5+130, 73, 20);
    self.typeLab.text = viewModel.StatusName;
    
    self.typeImg.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame)+6, 21.5+130, 73, 20);
    self.typeImg.image = [UIImage imageNamed:@"标签"];
    
    self.contentLab.frame = CGRectMake(15, CGRectGetMaxY(self.titleLab.frame)+15, BXScreenW - 30, 1000);
    self.contentLab.text = viewModel.Intro;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentLab.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentLab.text length])];
    self.contentLab.attributedText = attributedString;
    self.contentLab.numberOfLines = 0;
    [self.contentLab sizeToFit];
    
    
//    self.timeLab.frame = CGRectMake(15, CGRectGetMaxY(self.contentLab.frame)+20, BXScreenW - 30, 15);
//    self.timeLab.text = @"投稿时间：2017.2.12 - 2017.3.4";
//    
//    self.guizeLab.frame = CGRectMake(15, CGRectGetMaxY(self.timeLab.frame)+10, BXScreenW - 30, 15);
//    self.guizeLab.text = @"仅限新作品投稿（活动发布后创建的作品为新作品）";
    
    self.lineLab.frame = CGRectMake(0, CGRectGetMaxY(self.contentLab.frame)+20, BXScreenW, 10);
    
    self.height = CGRectGetMaxY(self.lineLab.frame);
}

@end
