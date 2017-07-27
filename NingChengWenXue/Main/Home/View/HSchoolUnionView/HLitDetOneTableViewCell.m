//
//  HLitDetOneTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HLitDetOneTableViewCell.h"

@implementation HLitDetOneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

- (void) setUpTableViewCellUI {
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = FIFFont;
    self.nameLab.textColor = BXColor(40,40,40);
    self.nameLab.text = @"社团作品";
    [self.contentView addSubview:self.nameLab];
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.image = [UIImage imageNamed:@"箭头"];
    [self.contentView addSubview:self.imgView];
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = THIRDFont;
    self.numLab.textColor = BXColor(152, 152, 152);
    [self.contentView addSubview:self.numLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lineLab.frame = CGRectMake(0, 0, BXScreenW, 0.5);
    self.nameLab.frame = CGRectMake(15, 1, 70, 42);
    self.numLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame)+10, 1, 100, 42);
    self.imgView.frame = CGRectMake(BXScreenW - 30, 12, 15, 20);
    
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
