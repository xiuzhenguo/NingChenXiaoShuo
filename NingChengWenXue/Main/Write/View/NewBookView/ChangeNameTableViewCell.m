//
//  ChangeNameTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/25.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ChangeNameTableViewCell.h"

@implementation ChangeNameTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.img = [[UIImageView alloc] init];
    self.img.image = [UIImage imageNamed:@"作品名称"];
    [self.contentView addSubview:self.img];
    
    self.tectfield = [[UITextField alloc] init];
    self.tectfield.font = [UIFont systemFontOfSize:16];
    self.tectfield.textColor = BXColor(236,105,65);
    self.tectfield.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:self.tectfield];
    
    self.btn = [[UIButton alloc] init];
    [self.btn setTitle:@"确定" forState:UIControlStateNormal];
    [self.btn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    self.btn.layer.cornerRadius = 5;
    self.btn.titleLabel.font = FIFFont;
    self.btn.layer.borderColor = BXColor(236,105,65).CGColor;
    self.btn.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.btn];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.img.frame = CGRectMake(15, 7, 20, 30);
    self.tectfield.frame = CGRectMake(CGRectGetMaxX(self.img.frame)+5, 0, BXScreenW - 120, 44);
    self.btn.frame = CGRectMake(BXScreenW - 70, 10, 45, 24);
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
