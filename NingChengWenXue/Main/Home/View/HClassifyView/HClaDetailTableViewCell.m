//
//  HClaDetailTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HClaDetailTableViewCell.h"

@implementation HClaDetailTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

- (void) setUpTableViewCellUI {
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:16];
    self.nameLab.textColor = BXColor(40, 40, 40);
    [self.contentView addSubview:self.nameLab];
    
    self.authorLab = [[UILabel alloc] init];
    self.authorLab.font = THIRDFont;
    self.authorLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.authorLab];
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = THIRDFont;
    self.numLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.numLab];
    
    // 竖线
    self.longLab = [[UILabel alloc] init];
    self.longLab.backgroundColor = BXColor(101,101,101);
    [self.contentView addSubview:self.longLab];
    // 签约
    self.signLab = [[UILabel alloc] init];
    self.signLab.font = THIRDFont;
    self.signLab.textColor = BXColor(236,105,65);
    [self.contentView addSubview:self.signLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
    
}

- (void)setViewModel:(BookKeysModel *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    // 图片
    self.imgView.frame = CGRectMake(15, 10, 93, 60);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.FictionImage] placeholderImage:[UIImage imageNamed:@"书"]];
    
    // 小说名
    self.nameLab.text = viewModel.FictionName;
    CGRect rectLab = [self.nameLab.text boundingRectWithSize:CGSizeMake(BXScreenW-118-40, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.nameLab.font} context:nil];
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 10, rectLab.size.width, 15);
    
    self.longLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame)+5, 13, 0.5, 12);
    
    self.signLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame)+10, 12, 40, 13);
    if (viewModel.Sign == YES) {
        self.signLab.text = @"签约";
    }else{
        self.signLab.text = @"未签约";
    }
    
    
    self.authorLab.frame = CGRectMake(118, CGRectGetMaxY(self.nameLab.frame)+10, BXScreenW - 133, 15);
    self.authorLab.text = [NSString stringWithFormat:@"by: %@",viewModel.AuthorName];
    [self.authorLab sizeToFit];
    
    
    self.numLab.frame = CGRectMake(118, CGRectGetMaxY(self.authorLab.frame)+5, BXScreenW - 93 - 40, 15);
    self.numLab.text = [NSString stringWithFormat:@"%ld阅读",viewModel.Reader];
    [self.numLab sizeToFit];
    
    
    
    self.lineLab.frame = CGRectMake(0, CGRectGetMaxY(self.imgView.frame)+9.5, BXScreenW, 0.5);
    
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
