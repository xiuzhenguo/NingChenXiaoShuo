//
//  SwichTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/24.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "SwichTableViewCell.h"

@implementation SwichTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.text = @"代表作";
    self.nameLab.font = FIFFont;
    self.nameLab.textColor = BXColor(40, 40, 40);
    [self.contentView addSubview:self.nameLab];
    
    self.swi = [[UISwitch alloc] init];
    
    [self.contentView addSubview:self.swi];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.nameLab.frame = CGRectMake(15, 0, 130, 43.5);
    self.swi.frame = CGRectMake(BXScreenW - 65, 8, 50, 27);
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
