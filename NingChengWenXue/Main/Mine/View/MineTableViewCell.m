//
//  MineTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/14.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

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
    self.nameLab.font = FIFFont;
    self.nameLab.textColor = BXColor(35,35,35);
    [self.contentView addSubview:self.nameLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(15, 14, 15, 15);
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+15, 0, BXScreenW - 80, 43.5);
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
