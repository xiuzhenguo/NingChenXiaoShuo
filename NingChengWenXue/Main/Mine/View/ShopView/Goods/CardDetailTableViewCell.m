//
//  CardDetailTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/30.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CardDetailTableViewCell.h"

@implementation CardDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

- (void) setUpTableViewCellUI {
    
    self.btn = [[UIButton alloc] init];
    self.btn.backgroundColor = [UIColor whiteColor];
    self.btn.selected = NO;
    [self.contentView addSubview:self.btn];
    
    self.imgView = [[UIImageView alloc] init];
    [self.btn addSubview:self.imgView];
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.textColor = BXColor(40, 40, 40);
    self.typeLab.font = FIFFont;
    [self.btn addSubview:self.typeLab];
    
    self.priceLab = [[UILabel alloc] init];
    self.priceLab.textColor = BXColor(236,105,65);
    self.priceLab.font = [UIFont boldSystemFontOfSize:15];
    self.priceLab.textAlignment = NSTextAlignmentRight;
    [self.btn addSubview:self.priceLab];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.btn.frame = CGRectMake(0, 0, BXScreenW, 40);
    self.imgView.frame = CGRectMake(15, 15, 15, 15);
    self.typeLab.frame = CGRectMake(40, 15, 100, 15);
    self.priceLab.frame = CGRectMake(160, 15, BXScreenW - 175, 15);
    
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
