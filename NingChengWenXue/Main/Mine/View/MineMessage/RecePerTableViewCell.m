//
//  RecePerTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "RecePerTableViewCell.h"

@implementation RecePerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

- (void) setUpTableViewCellUI {
    
    self.perLab = [[UILabel alloc] init];
    self.perLab.font = FIFFont;
    self.perLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.perLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.perLab.frame = CGRectMake(15, 0.5, BXScreenW - 30, 43.5);
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
