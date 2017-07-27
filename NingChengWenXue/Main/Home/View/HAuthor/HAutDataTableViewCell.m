//
//  HAutDataTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutDataTableViewCell.h"

@implementation HAutDataTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = FIFFont;
    self.titleLab.textColor = BXColor(40, 40, 40);
    [self.contentView addSubview:self.titleLab];
    
    self.infoLab = [[UILabel alloc] init];
    self.infoLab.font = FIFFont;
    self.infoLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.infoLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.titleLab.frame = CGRectMake(15, 0.5, 80, 43.5);
    self.infoLab.frame = CGRectMake(95, 0.5, BXScreenW - 115 - 15, 43.5);
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
