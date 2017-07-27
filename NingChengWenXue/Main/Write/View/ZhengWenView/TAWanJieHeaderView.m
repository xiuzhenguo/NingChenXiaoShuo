//
//  TAWanJieHeaderView.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TAWanJieHeaderView.h"

@implementation TAWanJieHeaderView

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
    // 投稿时间
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = THIRDFont;
    self.timeLab.textColor = BXColor(152,152,152);
    [self addSubview:self.timeLab];
    // 内容
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.font = THIRDFont;
    self.contentLab.textColor = BXColor(152,152,152);
    [self addSubview:self.contentLab];
    // 活动图片
    self.imgView = [[UIImageView alloc] init];
    [self addSubview:self.imgView];
    
    self.btn = [[UIButton alloc] init];
    [self addSubview:self.btn];
    // 活动规则
    self.guizeLab = [[UILabel alloc] init];
    self.guizeLab.textColor = BXColor(236,105,65);
    self.guizeLab.font = FIFFont;
    [self.btn addSubview:self.guizeLab];
    
    self.moreImg = [[UIImageView alloc] init];
    [self.btn addSubview:self.moreImg];
    
    // 进度
    self.typeImg = [[UIImageView alloc] init];
    [self addSubview:self.typeImg];
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.textColor = BXColor(152, 152, 152);
    self.typeLab.font = ELEFont;
    self.typeLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.typeLab];
    
    // 获奖作品
    self.workImg = [[UIImageView alloc] init];
    [self addSubview:self.workImg];
    
    self.workLab = [[UILabel alloc] init];
    self.workLab.font = [UIFont boldSystemFontOfSize:15];
    self.workLab.textColor = [UIColor whiteColor];
    self.workLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.workLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(242, 242, 242);
    [self addSubview:self.lineLab];
    
    self.oneView = [[UIView alloc] init];
    self.oneView.backgroundColor = BXColor(242, 242, 242);
    [self addSubview:self.oneView];
    
    self.twoView = [[UIView alloc] init];
    self.twoView.backgroundColor = BXColor(242, 242, 242);
    [self addSubview:self.twoView];
}

- (void)setModel:(ViewModel *)model{
    for (UIView *view in self.subviews) {
        view.frame = CGRectZero;
    }
    
    self.imgView.frame = CGRectMake(0, 0, BXScreenW, 130);
    self.imgView.image = [UIImage imageNamed:@"上首页_3"];
    
    self.oneView.frame = CGRectMake(0, 130, BXScreenW, 10);
    // 活动名
    self.titleLab.text = @"校园那点事征文";
    CGRect nameWith = [self.titleLab.text boundingRectWithSize:CGSizeMake(BXScreenW - 110, 15) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(self.titleLab.font)} context:nil];
    self.titleLab.frame = CGRectMake(15, 155, nameWith.size.width, 15);
    // 进度
    self.typeLab.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame)+6, 152.5, 73, 20);
    self.typeLab.text = @"投稿阶段";
    
    self.typeImg.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame)+6, 152.5, 73, 20);
    self.typeImg.image = [UIImage imageNamed:@"标签"];
    
    self.contentLab.frame = CGRectMake(15, CGRectGetMaxY(self.titleLab.frame)+15, BXScreenW - 30, 1000);
    self.contentLab.text = @"的护卫凤凰网也更符合因违反微风过文艺范非工业误国府夜无个非官方会计师醋和夫和非要发个我邮费给物业费我发文件不符合发给我二月份个网页复位后覅了花都区后我父亲";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentLab.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentLab.text length])];
    self.contentLab.attributedText = attributedString;
    self.contentLab.numberOfLines = 0;
    [self.contentLab sizeToFit];
   
    
    self.timeLab.frame = CGRectMake(15, CGRectGetMaxY(self.contentLab.frame)+15, BXScreenW - 30, 15);
    self.timeLab.text = @"投稿时间：2017.2.12 - 2017.3.4";
    
    self.lineLab.frame = CGRectMake(0, CGRectGetMaxY(self.timeLab.frame)+14.5, BXScreenW, 0.5);
    
    self.btn.frame = CGRectMake(0, CGRectGetMaxY(self.lineLab.frame), BXScreenW, 44);
    self.guizeLab.frame = CGRectMake(15, 0, BXScreenW - 150, 44);
    self.guizeLab.text = @"活动规则";
    
    self.moreImg.frame = CGRectMake(BXScreenW - 25, 20, 15, 15);
    self.moreImg.image = [UIImage imageNamed:@"箭头"];
    
    self.twoView.frame = CGRectMake(0, CGRectGetMaxY(self.btn.frame)+10, BXScreenW, 10);
    
    self.workImg.frame = CGRectMake(15, CGRectGetMaxY(self.twoView.frame)+15, BXScreenW - 30, 44);
    self.workImg.image = [UIImage imageNamed:@"获奖作品"];
    
    self.workLab.frame = CGRectMake(15, CGRectGetMaxY(self.twoView.frame)+15, BXScreenW - 30, 44);
    self.workLab.text = @"获奖作品";
    
    self.height = CGRectGetMaxY(self.workImg.frame)+5;
}

@end
