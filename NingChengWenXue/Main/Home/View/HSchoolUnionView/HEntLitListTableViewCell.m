//
//  HEntLitListTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HEntLitListTableViewCell.h"

@implementation HEntLitListTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

- (void) setUpTableViewCellUI {
    
    self.rankLab = [[UILabel alloc] init];
    self.rankLab.font = THIRDFont;
    self.rankLab.textColor = BXColor(152, 152, 152);
    [self.contentView addSubview:self.rankLab];
    self.rankLab.textAlignment = NSTextAlignmentCenter;
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.layer.cornerRadius = 25;
    self.imgView.clipsToBounds = YES;
    [self.contentView addSubview:self.imgView];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = FIFFont;
    self.nameLab.textColor = BXColor(35,35,35);
    [self.contentView addSubview:self.nameLab];
    
    self.schNameLab = [[UILabel alloc] init];
    self.schNameLab.font = THIRDFont;
    self.schNameLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.schNameLab];
    
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = THIRDFont;
    self.numLab.layer.cornerRadius = 1.5;
    self.numLab.textColor = BXColor(152, 152, 152);
    [self.contentView addSubview:self.numLab];
    
    self.perNumLab = [[UILabel alloc] init];
    self.perNumLab.font = ELEFont;
    self.perNumLab.textColor = BXColor(152, 152, 152);
    self.perNumLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.perNumLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lineLab.frame = CGRectMake(0, 0, BXScreenW, 0.5);
    //排名
    self.rankLab.frame = CGRectMake(15, 25, 20, 20);
    // 图片
    self.imgView.frame = CGRectMake(50, 12.5, 50, 50);
    // 名字
    self.nameLab.frame = CGRectMake(110, 12.5, BXScreenW - 125, 15);
    // 大学
    self.schNameLab.frame = CGRectMake(110, CGRectGetMaxY(self.nameLab.frame)+5, 130, 13);
    // 作品数
    self.numLab.frame = CGRectMake(110, CGRectGetMaxY(self.schNameLab.frame)+5, 130, 13);
    // 人数
    self.perNumLab.frame = CGRectMake(245, 27.5, BXScreenW - 260, 25);
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
