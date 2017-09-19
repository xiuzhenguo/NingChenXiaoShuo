//
//  MReceMessListTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MReceMessListTableViewCell.h"

@implementation MReceMessListTableViewCell

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
    self.nameLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.nameLab];
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = THIRDFont;
    self.timeLab.textColor = BXColor(152,152,152);
    self.timeLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.timeLab];
    
    self.perLab = [[UILabel alloc] init];
    self.perLab.font = THIRDFont;
    self.perLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.perLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(15, 15, 30, 30);
    self.nameLab.frame = CGRectMake(55, 10, BXScreenW - 70 - 80, 20);
    self.perLab.frame = CGRectMake(55, 35, BXScreenW - 70, 15);
    self.timeLab.frame = CGRectMake(BXScreenW - 90, 15, 80, 15);
    self.lineLab.frame = CGRectMake(0, 0, BXScreenW, 0.5);
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
