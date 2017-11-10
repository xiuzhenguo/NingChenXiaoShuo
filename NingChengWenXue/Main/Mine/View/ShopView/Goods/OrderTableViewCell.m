//
//  OrderTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/11/7.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpTableViewCellUI];
    }
    return self;
}

-(void)setUpTableViewCellUI{
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = FIFFont;
    self.titleLab.textColor = BXColor(40, 40, 40);
    [self.contentView addSubview:self.titleLab];
    
    self.priceLab = [[UILabel alloc] init];
    self.priceLab.font = FIFFont;
    self.priceLab.textColor = BXColor(101,101,101);
    self.priceLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.priceLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLab.frame = CGRectMake(15, 0, 150, 43.5);
    self.priceLab.frame = CGRectMake(160, 15, BXScreenW - 175, 15);
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
