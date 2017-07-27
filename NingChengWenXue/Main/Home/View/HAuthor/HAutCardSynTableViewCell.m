//
//  HAutCardSynTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/29.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutCardSynTableViewCell.h"

@implementation HAutCardSynTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpTableViewCellUI];
    }
    return self;
}

-(void) setUpTableViewCellUI {
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(242, 242, 242);
    [self.contentView addSubview:self.lineLab];
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.textColor = BXColor(40, 40, 40);
    self.nameLab.font = FIFFont;
    [self.contentView addSubview:self.nameLab];
    
    self.btn = [[UIButton alloc] init];
    [self.btn setTitle:@"合成" forState:UIControlStateNormal];
    self.btn.titleLabel.font = FIFFont;
    self.btn.layer.cornerRadius = 5;
    [self.contentView addSubview:self.btn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.lineLab.frame = CGRectMake(0, 0, BXScreenW, 5);
    self.imgView.frame = CGRectMake(15, 15, 105, 132);
    self.nameLab.frame = CGRectMake(135, 15, BXScreenW - 135 - 80, 132);
    self.btn.frame = CGRectMake(BXScreenW - 75, CGRectGetMidY(self.imgView.frame)-15, 60, 29);
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
