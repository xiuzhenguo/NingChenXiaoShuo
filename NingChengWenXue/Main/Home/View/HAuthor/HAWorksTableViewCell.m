//
//  HAWorksTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/22.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAWorksTableViewCell.h"

@implementation HAWorksTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:15];
    self.nameLab.textColor = BXColor(35, 35, 35);
    [self.contentView addSubview:self.nameLab];
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = THIRDFont;
    self.timeLab.textColor = BXColor(101,101,101);
    [self.contentView addSubview:self.timeLab];
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = THIRDFont;
    self.numLab.textColor = BXColor(101,101,101);
    [self.contentView addSubview:self.numLab];
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(15, 10, 93, 59);
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 10, BXScreenW - 93 - 40, 20);
    self.timeLab.frame = CGRectMake(93+25, CGRectGetMaxY(self.nameLab.frame)+5, BXScreenW - 93 - 60, 15);
    self.numLab.frame = CGRectMake(93+25, CGRectGetMaxY(self.timeLab.frame)+5, BXScreenW - 93 - 30, 15);
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
