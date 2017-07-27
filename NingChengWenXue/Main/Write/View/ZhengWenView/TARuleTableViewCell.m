//
//  TARuleTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TARuleTableViewCell.h"

@implementation TARuleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    // 活动名
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = FIFFont;
    self.titleLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.titleLab];
    // 投稿时间
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = THIRDFont;
    self.timeLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.timeLab];
    // 内容
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.font = THIRDFont;
    self.contentLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.contentLab];

    // 活动规则
    self.guizeLab = [[UILabel alloc] init];
    self.guizeLab.textColor = BXColor(152, 152, 152);
    self.guizeLab.font = THIRDFont;
    [self.contentView addSubview:self.guizeLab];
    
    // 进度
    self.typeImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.typeImg];
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.textColor = BXColor(152, 152, 152);
    self.typeLab.font = ELEFont;
    self.typeLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.typeLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(242, 242, 242);
    [self.contentView addSubview:self.lineLab];
}

- (void)setViewModel:(ViewModel *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    // 活动名
    self.titleLab.text = @"校园那点事征文";
    CGRect nameWith = [self.titleLab.text boundingRectWithSize:CGSizeMake(BXScreenW - 110, 15) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(self.titleLab.font)} context:nil];
    self.titleLab.frame = CGRectMake(15, 23, nameWith.size.width, 15);
    // 进度
    self.typeLab.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame)+6, 21.5, 73, 20);
    self.typeLab.text = @"投稿阶段";
    
    self.typeImg.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame)+6, 21.5, 73, 20);
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
    
    
    self.timeLab.frame = CGRectMake(15, CGRectGetMaxY(self.contentLab.frame)+20, BXScreenW - 30, 15);
    self.timeLab.text = @"投稿时间：2017.2.12 - 2017.3.4";
    
    self.guizeLab.frame = CGRectMake(15, CGRectGetMaxY(self.timeLab.frame)+10, BXScreenW - 30, 15);
    self.guizeLab.text = @"仅限新作品投稿（活动发布后创建的作品为新作品）";
    
    self.lineLab.frame = CGRectMake(0, CGRectGetMaxY(self.guizeLab.frame)+15, BXScreenW, 10);
    
    self.height = CGRectGetMaxY(self.lineLab.frame);
}
    
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
