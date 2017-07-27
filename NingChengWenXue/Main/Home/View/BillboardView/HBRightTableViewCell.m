//
//  HBRightTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/1.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HBRightTableViewCell.h"

@implementation HBRightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 小说名
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.font = [UIFont boldSystemFontOfSize:16];
        self.nameLab.textColor = BXColor(40, 40, 40);
        [self.contentView addSubview:self.nameLab];
        // 竖线
        self.longLab = [[UILabel alloc] init];
        self.longLab.backgroundColor = BXColor(101,101,101);
        [self.contentView addSubview:self.longLab];
        // 签约
        self.signLab = [[UILabel alloc] init];
        self.signLab.font = THIRDFont;
        self.signLab.textColor = BXColor(236,105,65);
        [self.contentView addSubview:self.signLab];
        // 作者
        self.authorLab = [[UILabel alloc] init];
        self.authorLab.font = THIRDFont;
        self.authorLab.textColor = BXColor(152,152,152);
        [self.contentView addSubview:self.authorLab];
        // 金币
        self.moneyLab = [[UILabel alloc] init];
        self.moneyLab.font = ELEFont;
        self.moneyLab.textColor = BXColor(236,105,65);
        self.moneyLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.moneyLab];
        // 阅读人数
        self.numLab = [[UILabel alloc] init];
        self.numLab.font = THIRDFont;
        self.numLab.textColor = BXColor(152,152,152);
        [self.contentView addSubview:self.numLab];
        // 类型
        self.typeLab = [[UILabel alloc] init];
        self.typeLab.font = ELEFont;
        self.typeLab.textColor = BXColor(152,152,152);
        self.typeLab.borderWidth = 0.5;
        self.typeLab.borderColor = BXColor(152,152,152);
        self.typeLab.layer.cornerRadius = 2;
        [self.contentView addSubview:self.typeLab];
        self.typeLab.textAlignment = NSTextAlignmentCenter;
        // 图片
        self.imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imgView];
        
        self.lineLab = [[UILabel alloc] init];
        self.lineLab.backgroundColor = BXColor(195,195,195);
        [self.contentView addSubview:self.lineLab];
        
        
    }
    return self;
}

- (void)setViewModel:(BillboardModel *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    
    
    CGFloat width = self.contentView.frame.size.width;
    
    self.imgView.frame = CGRectMake(10, 10, 93, 60);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.FictionImage] placeholderImage:[UIImage imageNamed:@"书"]];
    
    self.nameLab.text = viewModel.FictionName;
    CGRect rectLab = [self.nameLab.text boundingRectWithSize:CGSizeMake(width-113-55, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.nameLab.font} context:nil];
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 10, rectLab.size.width, 15);
    
    self.longLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame)+5, 13, 0.5, 12);
    
    self.signLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame)+10, 12, 40, 13);
    if ([viewModel.IsSign isEqualToString:@"1"]) {
        self.signLab.text = @"签约";
    }else{
        self.signLab.text = @"未签约";
    }
    
    self.authorLab.frame = CGRectMake(113, CGRectGetMaxY(self.nameLab.frame)+10, 150, 15);
    self.authorLab.text = [NSString stringWithFormat:@"by：%@",viewModel.AuthorName];
    [self.authorLab sizeToFit];
    
    self.moneyLab.frame = CGRectMake(width - 200, CGRectGetMaxY(self.nameLab.frame)+10, 185, 15);
    self.moneyLab.text = viewModel.Unit;
    
    self.numLab.frame = CGRectMake(113, CGRectGetMaxY(self.authorLab.frame)+5, 200, 15);
    self.numLab.text = viewModel.ReadCount;
    [self.numLab sizeToFit];
    
    self.typeLab.text = viewModel.ClassName;
    CGRect rect = [self.typeLab.text boundingRectWithSize:CGSizeMake(self.frame.size.width -20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.typeLab.font} context:nil];
    CGFloat BtnW = rect.size.width + 10;
    self.typeLab.frame = CGRectMake(width-BtnW-15, CGRectGetMaxY(self.moneyLab.frame)+5, BtnW, 15);
    
    self.lineLab.frame = CGRectMake(9.5, CGRectGetMaxY(self.imgView.frame)+10, width-10, 0.5);
    
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
