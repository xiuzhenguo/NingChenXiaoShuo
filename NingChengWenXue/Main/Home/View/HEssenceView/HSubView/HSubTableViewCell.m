//
//  HSubTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/23.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HSubTableViewCell.h"

@implementation HSubTableViewCell

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
    self.nameLab.font = [UIFont systemFontOfSize:16];
    self.nameLab.textColor = BXColor(40, 40, 40);
    [self.contentView addSubview:self.nameLab];
    
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.font = THIRDFont;
    self.typeLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.typeLab];
    
    self.backLab = [[UILabel alloc] init];
    self.backLab.backgroundColor = BXColor(242,242,242);
    [self.contentView addSubview:self.backLab];
    
    
    self.imgBtn = [[UIButton alloc] init];
    [self.contentView addSubview:self.imgBtn];
    //    [self.imgBtn addTarget:self action:@selector(ciclkImgButton:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.imgBtn setImage:[UIImage imageNamed:@"默认_1"] forState:UIControlStateNormal];
    self.imgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.imgBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);

    self.imgBtn.selected = NO;
    
}

- (void)clickBtn:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(15, 10, 45, 45);
    self.nameLab.frame = CGRectMake(70, 15, 120, 15);
    self.typeLab.frame = CGRectMake(70, 35, BXScreenW - 150, 15);
    self.backLab.frame = CGRectMake(0, 65, BXScreenW, 10);
    self.imgBtn.frame = CGRectMake(0, 5, BXScreenW, 60);
    
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
