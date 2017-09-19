//
//  MinePerDataTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MinePerDataTableViewCell.h"

@implementation MinePerDataTableViewCell

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
    self.nameLab.textColor = BXColor(101,101,101);
    [self.contentView addSubview:self.nameLab];
    
    self.conLab = [[UILabel alloc] init];
    self.conLab.font = FIFFont;
    self.conLab.textColor = BXColor(40,40,40);
    self.conLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.conLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.nameLab.frame = CGRectMake(15, 0, 50, 43.5);
    self.conLab.frame = CGRectMake(70, 0, BXScreenW - 85, 43.5);
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
