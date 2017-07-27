//
//  HBLeftTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/1.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HBLeftTableViewCell.h"

@implementation HBLeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.font = THIRDFont;
        self.nameLab.textColor = BXColor(40, 40, 40);
        self.nameLab.highlightedTextColor = BXColor(236,105,65);
        self.nameLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.nameLab];
        
        self.lineLab = [[UILabel alloc] init];
        self.lineLab.backgroundColor = BXColor(195,195,195);
        [self.contentView addSubview:self.lineLab];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLab.frame = CGRectMake(0, 0, 65, 43.5);
    self.lineLab.frame = CGRectMake(0, 43.5, 65, 0.5);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.nameLab.highlighted = selected;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
