//
//  HAutPerTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/29.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutPerTableViewCell.h"

@implementation HAutPerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpTableViewCellUI];
    }
    return self;
}

-(void) setUpTableViewCellUI {
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.layer.cornerRadius = 22.5;
    self.imgView.clipsToBounds = YES;
    [self.contentView addSubview:self.imgView];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:16];
    self.nameLab.textColor = BXColor(35,35,35);
    [self.contentView addSubview:self.nameLab];
    
    self.bookLab = [[UILabel alloc] init];
    self.bookLab.font = THIRDFont;
    self.bookLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.bookLab];
    
    self.btn = [[UIButton alloc] init];
    self.btn.titleLabel.font = THIRDFont;
    self.btn.layer.cornerRadius = 3;
    self.btn.borderWidth = 0.5;
    [self.contentView addSubview:self.btn];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.lineLab.frame = CGRectMake(0, 0, BXScreenW, 0.5);
    
    self.imgView.frame = CGRectMake(15, 10, 45, 45);
    
    self.nameLab.frame = CGRectMake(70, 15, BXScreenW - 155, 16);
    
    self.bookLab.frame = CGRectMake(70, CGRectGetMaxY(self.nameLab.frame)+5, BXScreenW - 155, 14);
    
    self.btn.frame = CGRectMake(BXScreenW - 75, 19, 60, 26);
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
