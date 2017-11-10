
//
//  InforImageTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/13.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "InforImageTableViewCell.h"

@implementation InforImageTableViewCell

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
    [self.contentView addSubview:self.nameLab];
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.image = [UIImage imageNamed:@"打赏头像"];
    self.imgView.layer.cornerRadius = 22;
    self.imgView.clipsToBounds = YES;
    [self.contentView addSubview:self.imgView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.nameLab.frame = CGRectMake(15, 0, 80, 55);
    self.imgView.frame = CGRectMake(BXScreenW - 75, 5.5, 44, 44);
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
