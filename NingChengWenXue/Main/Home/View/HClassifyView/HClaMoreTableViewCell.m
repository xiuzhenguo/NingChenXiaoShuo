//
//  HClaMoreTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HClaMoreTableViewCell.h"

@implementation HClaMoreTableViewCell

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
    self.nameLab.textColor = BXColor(40, 40, 40);
    [self.contentView addSubview:self.nameLab];
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = FIFFont;
    self.numLab.textColor = BXColor(152,152,152);
    self.numLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.numLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLab.frame = CGRectMake(15, 0, 150, 43.5);
    self.numLab.frame = CGRectMake(165, 0, BXScreenW - 180, 43.5);
    self.lineLab.frame = CGRectMake(0, 43.5, BXScreenW, 0.5);
    
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
